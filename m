From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH v2 07/14] mingw: add kill emulation
Date: Sat, 16 Jan 2010 22:56:49 +0100
Message-ID: <40aa078e1001161356i1efc7e42q5139614d95bc181@mail.gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
	 <1263591033-4992-8-git-send-email-kusmabite@gmail.com>
	 <201001152331.39199.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: 3IzZSSwkOB_YisqkYZgrcemmejckYgj.amkkqwqegremmejcepmsnq.amk@listserv.bounces.google.com Sat Jan 16 22:57:09 2010
Return-path: <3IzZSSwkOB_YisqkYZgrcemmejckYgj.amkkqwqegremmejcepmsnq.amk@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f137.google.com ([209.85.210.137])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWGdo-00060M-RX
	for gcvm-msysgit@m.gmane.org; Sat, 16 Jan 2010 22:57:08 +0100
Received: by yxe1 with SMTP id 1sf3991078yxe.3
        for <gcvm-msysgit@m.gmane.org>; Sat, 16 Jan 2010 13:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:mime-version:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe:content-type
         :content-transfer-encoding;
        bh=mSHRA7Lnx1gujKYZdpQXCGmLxvij+j/FjzS85atz2lo=;
        b=gJCyx807bceay1Gt/UiFnnNZO94oNl/sgyTX3WMDDPcL97AxHDW205YbWvxgttjVeT
         5ZcbLqBO7F6ex9e3T9G9gu0Tpn6nBHIISl256U4CoH9PMZArChlXVWdoUh/RBshEP9y0
         3DwJRqdEeZTEfpeWcfn9b1BmdbdAN965Fnpco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe:content-type
         :content-transfer-encoding;
        b=ejwMCnMnAsxgYi7LYr4oojfvJ7Tei1lOora1TrjWcOabk7FB1fHYQSBhqP5b3SMJwM
         DBr8nlFJr1he3ptB1nRzMLlhAAClZc94kfGOzYi4/rB8SkVjHU8UgrZpLhe60oQSdhB5
         Vm4jHYbLQDpAHAvIZZMTPg4nRMTWml3obFXeU=
Received: by 10.101.180.10 with SMTP id h10mr315683anp.18.1263679011766;
        Sat, 16 Jan 2010 13:56:51 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.213.60.1 with SMTP id n1ls671030ebh.3.p; Sat, 16 Jan 2010 
	13:56:50 -0800 (PST)
Received: by 10.213.100.228 with SMTP id z36mr346139ebn.12.1263679010299;
        Sat, 16 Jan 2010 13:56:50 -0800 (PST)
Received: by 10.213.100.228 with SMTP id z36mr346138ebn.12.1263679010283;
        Sat, 16 Jan 2010 13:56:50 -0800 (PST)
Received: from mail-ew0-f220.google.com (mail-ew0-f220.google.com [209.85.219.220])
        by gmr-mx.google.com with ESMTP id 12si330769ewy.10.2010.01.16.13.56.49;
        Sat, 16 Jan 2010 13:56:49 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.220 as permitted sender) client-ip=209.85.219.220;
Received: by ewy20 with SMTP id 20so2068338ewy.0
        for <msysgit@googlegroups.com>; Sat, 16 Jan 2010 13:56:49 -0800 (PST)
Received: by 10.216.88.136 with SMTP id a8mr1379504wef.77.1263679009089; Sat, 
	16 Jan 2010 13:56:49 -0800 (PST)
In-Reply-To: <201001152331.39199.j6t@kdbg.org>
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of kusmabite@googlemail.com designates 209.85.219.220 as permitted 
	sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) 
	header.i=@googlemail.com
X-Original-Sender: kusmabite@googlemail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=>
X-Thread-Url: http://groups.google.com/group/msysgit/t/43ea563cecdc45de
X-Message-Url: http://groups.google.com/group/msysgit/msg/be179cc8acd9cecc
Sender: msysgit@googlegroups.com
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137264>

On Fri, Jan 15, 2010 at 11:31 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Freitag, 15. Januar 2010, Erik Faye-Lund wrote:
>> +int mingw_kill(pid_t pid, int sig)
>> +{
>> ...
>> + =A0 =A0 =A0 =A0 =A0 =A0 CloseHandle(h);
>> + =A0 =A0 =A0 =A0 =A0 =A0 errno =3D err_win_to_posix(GetLastError());
>
> Set errno before CloseHandle() to get the correct error.
>
> -- Hannes
>

Thanks for pointing that out. Corrected locally.

--=20
Erik "kusma" Faye-Lund
