From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] reset: Better warning message on git reset --mixed
 <paths>
Date: Sun, 15 Aug 2010 19:12:11 -0500
Message-ID: <20100816001211.GD3296@burratino>
References: <1281814499-11797-1-git-send-email-avarab@gmail.com>
 <20100814210505.GA2372@burratino>
 <7vvd7chcj4.fsf@alter.siamese.dyndns.org>
 <87tymwzjbk.fsf@catnip.gol.com>
 <AANLkTin3zyPvs3GjOt3=q6dOofFA2ba0sBAzt3=Ka1Wn@mail.gmail.com>
 <7vr5hzg1u1.fsf@alter.siamese.dyndns.org>
 <1281906304.32195.26.camel@lucy.SSG5-Serial-WLAN>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org,
	Ralf Ebert <info@ralfebert.de>
To: Ralf Ebert <ralf@ralfebert.de>
X-From: git-owner@vger.kernel.org Mon Aug 16 02:14:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OknL6-00081Y-LI
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 02:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610Ab0HPANv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 20:13:51 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34560 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403Ab0HPANu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Aug 2010 20:13:50 -0400
Received: by gxk23 with SMTP id 23so1708681gxk.19
        for <git@vger.kernel.org>; Sun, 15 Aug 2010 17:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=TyyaN5xOcw8CxTXEASHsvDLL0M6ayxwKouDHQXhzMCU=;
        b=TSg/v7TG8Yyi2kGDcTjhYwaVXu15zzaQlvUjr3eYNGPRojElQYZyldKykISi1MZGQD
         wsntDMXAM/UHPWx5MaRsmOKgfD1Evru2H4cSLMjy0ahqJ/WPECUgcOWqdWnY3i9Jf6Rx
         jofe2CBU+Hx834rKyzflJ5Ios07VEECwXySQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=l1MFo2u0KvUnr3fQDJLx+Re07VImCywAclm/iP3doU9ox9ij8yv7YoAONjUkMzHpRG
         ZqHZCeucoBCGzoKq6DT5YrsCRog9OXymugy4sYETfZR+zK02VCDfE0waDuxRzf78BD7Y
         lNKI993QrMNmK6kmv0lsM9ya1cbIXJHZs9PBA=
Received: by 10.150.189.15 with SMTP id m15mr4623116ybf.324.1281917629986;
        Sun, 15 Aug 2010 17:13:49 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q1sm5841691ybk.8.2010.08.15.17.13.48
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 15 Aug 2010 17:13:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1281906304.32195.26.camel@lucy.SSG5-Serial-WLAN>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153633>

Ralf Ebert wrote:

> git wipe [<path>]            # git reset [<file>]; git checkout [<fil=
e>]

git checkout HEAD -- <pathspec>.

So:

repository  ---> index ---> work tree

Limited by paths
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  r -> i: git reset <rev> -- <pathspec>
  i -> w: git checkout -- <pathspec>
  r -> w: git checkout <rev> -- <pathspec>

Updating head symref
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  r -> r: git checkout HEAD^0 && git reset --soft <rev> && git checkout=
 <rev>
  r -> i: git checkout HEAD^0 && git reset --mixed <rev> && git checkou=
t <rev>
  r -> w: git checkout <rev>

Resetting branch tip
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  r -> r: git reset --soft <rev>
  r -> i: git reset --mixed <rev>
  r -> w: git reset --hard <rev>

=E2=80=9Cgit checkout --no-update=E2=80=9D and =E2=80=9Cgit checkout --=
no-update --keep-index=E2=80=9D
do not sound very useful to me, so I am not suggesting adding them.
