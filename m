From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH] GIT-VERSION-GEN: restrict tags used
Date: Tue, 11 May 2010 18:01:00 -0500
Message-ID: <20100511230100.GB31163@progeny.tock>
References: <1273599198-1008-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 12 01:00:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OByRb-0002Y4-Ab
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 01:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585Ab0EKXAu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 May 2010 19:00:50 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35086 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426Ab0EKXAt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 19:00:49 -0400
Received: by gyg13 with SMTP id 13so3034436gyg.19
        for <git@vger.kernel.org>; Tue, 11 May 2010 16:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=xwpfYSpyctelUOk4ZNoODF47iNKENMOgN38JNcl28U4=;
        b=kQUVmpZC6wIDv36HfzV3UD9hRhUJb9Vd3wANrmTT5rFkU96XnWfUvdGNLFs7fUoZGj
         Bbscp4YaKHG+alcM3jrqhLhgPok9kBNlQ0FJji0q5agpbmixZDBYSBfVfIS7EypGWX7n
         wSgTMzlo3n+C+Xes9Q6J5YmsVMr0lLP4hpDN0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Q9HQg7PEm9g3W2Ku4Z/rnfA05wdOTTSIM4GogTTqN9QawbkTa222gK8qKlghlhB5tT
         62+cfNUsZr5pK1T4EIZE4qQZhmkKx5ozEvtp92P/iNf2z3IgGO6qqBPvdE07p/sxRu6+
         41a4TkYqPFC4/w9IsZgEIAHZKo69FRAvENEJ4=
Received: by 10.101.7.14 with SMTP id k14mr2990020ani.201.1273618847249;
        Tue, 11 May 2010 16:00:47 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm4721427ywh.6.2010.05.11.16.00.45
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 11 May 2010 16:00:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1273599198-1008-1-git-send-email-rctay89@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146910>

Tay Ray Chuan wrote:

> Restrict the tags used to generate the version string to those that
> begin with "v"

I like it.  Thanks!

> since git's tags for git-core (ie. excluding git-gui)
> are all of the form "vX.Y...".

git gui=E2=80=99s too, now.

> This is to avoid using private tags by the user in a clone of the git
> code repository, which may break certain machinery (eg. Makefile).

Not to mention gitk:

  set git_version [join [lrange [split [lindex [exec git version] end] =
=2E] 0 2] .]
  if {[package vcompare $git_version "1.6.1"] >=3D 0} {

This requires =E2=80=98git version=E2=80=99 output to have the form

  introducing 1.2.3.otherstuff

or there will be errors at startup time.

>   After this patch, perhaps we could advertise somewhere to git hacke=
rs
>   that tags beginning with "v" should be avoided.

Maybe v[0-9]* would make this problem harder to trip.

Jonathan
