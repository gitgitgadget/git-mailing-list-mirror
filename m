From: Johan Herland <johan@herland.net>
Subject: Re: [RFD] Making "git push [--force/--delete]" safer?
Date: Wed, 3 Jul 2013 12:11:57 +0200
Message-ID: <CALKQrgfQhVVC1NxizjCQdDmNfihfyEgypYddWB0CMTPqW9Mxtg@mail.gmail.com>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
	<CALKQrgenpqKUxOZ+p79NsaQD9M2-q4h93ZqN0oencVo-QZF=zg@mail.gmail.com>
	<CALKQrgdovWTd50LVDnNR+BhurWgSCKkhr88wCo01VZF3sd5PNg@mail.gmail.com>
	<7vli5ogh8r.fsf@alter.siamese.dyndns.org>
	<CALKQrge_REZKfds0T-owJOn2BvfLmHpk7yQeSog=yvofE_zKJQ@mail.gmail.com>
	<CAF5DW8++sc2VYmdJEjbD_ue_wtDFj21vcyFzNWU0M+rAm2X0sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 12:12:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuK2k-0004Ro-TI
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 12:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755907Ab3GCKME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 06:12:04 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:61153 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755906Ab3GCKMD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 06:12:03 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UuK2b-0006SI-Bz
	for git@vger.kernel.org; Wed, 03 Jul 2013 12:12:01 +0200
Received: from mail-ob0-f177.google.com ([209.85.214.177])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UuIm3-0004fm-HK
	for git@vger.kernel.org; Wed, 03 Jul 2013 10:50:51 +0200
Received: by mail-ob0-f177.google.com with SMTP id ta17so6748278obb.8
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 03:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=D+m97MxfHRXeas/X9ICJPEf3b2jIn483pMSwGRiExBk=;
        b=n13XI434NiRB+QNuVyRTt6Gks89n8h3N7o3XpONtDkBVolL6h/r6zHEvUmO67MV+n+
         RH+qtA+Jju8l5eeLWusaYv58bhEBhIOBZ34Zm8ku9rEmIex+C+NCe7GdbgnKI7zyjTT1
         Eo1QaTKJKATYBirXEiN8BR1i7HRTySj01JkxRe3BHbpvdMLCtsiKVYhyiL6fCXOBIvSp
         sRoax6MBqQvZyNTCejY+aXtITEbNZgBe0vf9DYTUA9v+CDOzw/AB7cxQ3BGFO9r5ytJF
         kOX7dvQY5r6EfvW3Id6PHQGObNCcahsQBImmCP+erfGrvy1tJfMBt/xfrt96dUa+gEL9
         VjAw==
X-Received: by 10.60.16.225 with SMTP id j1mr39664oed.97.1372846317298; Wed,
 03 Jul 2013 03:11:57 -0700 (PDT)
Received: by 10.182.102.5 with HTTP; Wed, 3 Jul 2013 03:11:57 -0700 (PDT)
In-Reply-To: <CAF5DW8++sc2VYmdJEjbD_ue_wtDFj21vcyFzNWU0M+rAm2X0sQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229483>

On Wed, Jul 3, 2013 at 12:06 PM, Jonathan del Strother
<maillist@steelskies.com> wrote:
> I'm struggling to think of instances where I wouldn't want this
> CAS-like behaviour.  Wouldn't it be better to make it the default when
> pushing, and allowing the current behaviour with "git push
> --blind-force" or something?

I believe I agree with you. I guess the reason this hasn't come up
before is that by far most of the pushes we do are either
fast-forwarding, or pushing into a non-shared repo (e.g. my own public
repo),  and this safety only really applies when we're forcing a
non-fast-forward push into a shared repo...

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
