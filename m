From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4] gc: reject if another gc is running, unless --force is given
Date: Sat, 10 Aug 2013 07:45:38 +0700
Message-ID: <CACsJy8D8EHpPGrc8MZnpvmh1j1LDudoZ0OO-zyfuDmhwLJqNsA@mail.gmail.com>
References: <1375712354-13171-1-git-send-email-pclouds@gmail.com>
 <1375959938-6395-1-git-send-email-pclouds@gmail.com> <CAPrKj1bO1jBsv73beA6LoeN09S-jWq8FYOP+WQ-AFwb1dn4Wsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Andres Perera <andres.p@zoho.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 02:46:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7xKC-0007Bl-LM
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 02:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030711Ab3HJAqK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Aug 2013 20:46:10 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:60115 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968075Ab3HJAqJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Aug 2013 20:46:09 -0400
Received: by mail-oa0-f53.google.com with SMTP id k18so7759667oag.12
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 17:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=H5VkwepE0aDGS335wK/Gd0q+6FJGcxU6/1VqtsBRD0o=;
        b=GpFjOXlNZvZp9EHueKG/T4p43ObGIx/w/IFTbUhr/8kAI0nHiOQsDDIy1mZCBI9FVw
         kfqP2RtEChoxtPufaDnDG4HPrVcX61yRJumlUX+x4iAeAFavP9BmVHVGQAnEriS1srI7
         dMYmDbC7HSD6tKvItPk17dsdhx1B3GhvlZaH/RZjywfSDCmH+7T4G7qdZK1z+ke10IsF
         eseXZdO6sEasYheVK+sb2mWmO4uJ0H7x0vgg9qPG55LL5a08BOEAff9vi2o334SAerEF
         Xn2OgUWkeMjyzZoyrt0XPrK6UheISDgDuQyPlRa8btIWx5d82IcGKATQmqnCD7N4Yj2n
         3AUA==
X-Received: by 10.182.128.6 with SMTP id nk6mr2612709obb.11.1376095568613;
 Fri, 09 Aug 2013 17:46:08 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Fri, 9 Aug 2013 17:45:38 -0700 (PDT)
In-Reply-To: <CAPrKj1bO1jBsv73beA6LoeN09S-jWq8FYOP+WQ-AFwb1dn4Wsw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232057>

On Fri, Aug 9, 2013 at 11:29 PM, Andres Perera <andres.p@zoho.com> wrot=
e:
> On Thu, Aug 8, 2013 at 6:35 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy <pclouds@gmail.com> wrote:
>> +       uintmax_t pid;
>
> pid_t is always an signed type, therefore unintmax_t does not make
> sense as a catch all value

I only catch real process id. In practice we don't have processes with
negative pid_t, do we? I can't find any document about this, but at
least waitpid seems to treat negative pid (except -1) just as an
indicator while the true pid is the positive counterpart.

> fork() returns -1 on failure, and its return type is pid_t. i don't
> know what fantasy unix system has an unsigned pid_t
--=20
Duy
