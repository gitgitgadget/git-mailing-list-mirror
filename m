From: "Clifford Caoile" <piyo@users.sourceforge.net>
Subject: Re: [PATCH 06/12] connect: Fix custom ports with plink
 (Putty's ssh)
Date: Sat, 5 Jul 2008 01:09:07 +0900
Message-ID: <1f748ec60807040909r4022d714s4487f5991f6020dc@mail.gmail.com>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-5-git-send-email-prohaska@zib.de> <1214987532-23640-6-git-send-email-prohaska@zib.de> <200807022104.20146.johannes.sixt@telecom.at> <7vod5euhw3.fsf@gitster.siamese.dyndns.org> <7188A895-D5B9-480E-8486-8A69B8861646@zib.de>
Reply-To: piyo@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, johannes.sixt@telecom.at,  msysGit <msysgit@googlegroups.com>, git@vger.kernel.org,  "Edward Z. Yang" <edwardzyang@thewritingpot.com>
To: prohaska@zib.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Fri Jul 04 18:10:18 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from py-out-1314.google.com ([64.233.166.175])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEnrO-0004qd-D3
	for gcvm-msysgit@m.gmane.org; Fri, 04 Jul 2008 18:10:10 +0200
Received: by py-out-1314.google.com with SMTP id u10so3424730pyb.2
        for <gcvm-msysgit@m.gmane.org>; Fri, 04 Jul 2008 09:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:received:received:message-id
         :date:from:reply-to:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere;
        bh=RNDZEc09vTocC/3lDJmycCWCyz4JLdfeSLI4ftR8wQY=;
        b=eAMSHMuEHvCAbhJXafnvGHs7/kywBSubsi5AZWs8Z8rNeSwyAV/V6dHih/TcY9b1hx
         Xs1PCrUvQCCMX4vn1+wLrmMb+4Gc1f0Nc0OIbxQnlP4cXLAJPr1uX8+peqonAbgt0MVy
         zUwKqPlDG3IExTnbs27yOWsYO5e80NUjj9EFg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:message-id:date:from:reply-to:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        b=mh5355Meto35t4y7QcQbgBIiJwC4zxIKW9W2iZ5XsaGNVIr1EiXBGIovEqQ/CjE63x
         /0NT97Cqk6WttBsFuuMbvRIsO8MXd3GTkuNrV3Xo9xnqOx+Pi9J7y9cp4w+3U6hOnQg+
         RyzfuRTa1Yv4MmnV8/OuMcopG9kcD7yjHXcUo=
Received: by 10.141.35.21 with SMTP id n21mr101699rvj.25.1215187750456;
        Fri, 04 Jul 2008 09:09:10 -0700 (PDT)
Received: by 10.106.193.17 with SMTP id q17gr2610prf.0;
	Fri, 04 Jul 2008 09:09:10 -0700 (PDT)
X-Sender: piyokun@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.114.173.8 with SMTP id v8mr891481wae.17.1215187749415; Fri, 04 Jul 2008 09:09:09 -0700 (PDT)
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169]) by mx.google.com with ESMTP id k36si164534waf.0.2008.07.04.09.09.08; Fri, 04 Jul 2008 09:09:09 -0700 (PDT)
Received-SPF: pass (google.com: domain of piyokun@gmail.com designates 209.85.200.169 as permitted sender) client-ip=209.85.200.169;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of piyokun@gmail.com designates 209.85.200.169 as permitted sender) smtp.mail=piyokun@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by wf-out-1314.google.com with SMTP id 25so1192017wfc.6 for <msysgit@googlegroups.com>; Fri, 04 Jul 2008 09:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from:reply-to :sender:to:subject:cc:in-reply-to:mime-version:content-type :content-transfer-encoding:content-disposition:references :x-google-sender-auth; bh=puSV0pX3uL70eUcGQgv6cdiK7/sIZxT0d0mMEORnQKU=; b=CLjVinfrduNm8XUt4M0NMTaoAR7qV2sRk9/DBbxE1AAdzTwaY/lccjDBhd751hkI0G F78xWkLQAsg1BYZMd8HJFXlCkjk4ix4C1JtXY6PeRenK6DSaM0KNBMnKhcyX4R8VU5Ec V8uv+WbTTFzxM1ZTH4m0EtbMYXEEqLfy7Y16E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to :mime-version:content-type:content-transfer-encoding :content-disposition:references:x-google-sender-auth; b=CSz6mt1z5IjpIq9TjzQIj8RCJdvq3/uSFla70hIisfd7E+jHjuJvYfjk0JRWEB0I2j gIW7/EKPS8R1AMWpMgTGOq/bCR3HNzQr43ypR5B8snwV9/Sn1gD7wsB+C6LbB6ZC4Fpx G7sKZ6EZwO/yZ1LUNirV1E8/jDsTQbhHlcVNA=
Received: by 10.142.194.4 with SMTP id r4mr292896wff.292.1215187747822; Fri, 04 Jul 2008 09:09:07 -0700 (PDT)
Received: by 10.142.212.5 with HTTP; Fri, 4 Jul 2008 09:09:07 -0700 (PDT)
In-Reply-To: <7188A895-D5B9-480E-8486-8A69B8861646@zib.de>
Content-Disposition: inline
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87399>


Hi:

On Fri, Jul 4, 2008 at 6:29 PM, Steffen Prohaska <prohaska@zib.de> wrote:
>
> On Jul 4, 2008, at 11:18 AM, Junio C Hamano wrote:
>
>> Johannes Sixt <johannes.sixt@telecom.at> writes:
>>
>>> What about installing a wrapper script, plinkssh, that does this:
>>
>> That's quite a nice solution with absolute minimum impact.
>
> It has minimum impact on the source code of git.  The same is not
> true, however, for the git user and the installer on Windows:
>
>  - The proposed plinkssh requires that plink is in the PATH.  This is
>   not necessarily the case on Windows.  If plink is not in the PATH,
>   then the user needs to modify plinkssh.
>
>  - The msysgit installer supports setting GIT_SSH to the full path
>   of plink.  It automatically detects this path based on Putty's
>   entries in the Windows registry.  If we choose the plinkssh
>   solution the installer has to be modified.

How about we create one more global environment variable
MSYSGIT_REAL_PLINK which points to the Windows plink during
installation? Then we set the GIT_SSH to the plinkssh, and the
proposed plinkssh can point to MSYSGIT_REAL_PLINK?

+ # fall back to plink if MSYSGIT_REAL_PLINK is not defined
+ # and hope plink is in the path
+ plink=${MSYSGIT_REAL_PLINK:-plink}

- exec plink $port "$@"
+ exec ${plink} $port "$@"

Perhaps I have traded one problem for another, because the msysgit
user still has to be aware of MSYSGIT_REAL_PLINK (at least she doesn't
have to set it up). And of course, the installer has to be modified to
accommodate plinkssh and my proposal.

Best regards,
Clifford Caoile
