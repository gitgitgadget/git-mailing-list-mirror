From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: bug: unexpected output for "git st" + suggestion
Date: Tue, 23 Nov 2010 14:22:43 +0100
Message-ID: <AANLkTinvM6OhLdeKt5MqEeNhZJx63X+KzOy_ngEsy0A2@mail.gmail.com>
References: <AANLkTimdKoGHapMTrA-bf_mEyMAEiiM0ALvLbZX8QJpv@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Tarek_Ziad=E9?= <ziade.tarek@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 14:23:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKsq0-0004qU-9p
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 14:23:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899Ab0KWNXH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 08:23:07 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61888 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370Ab0KWNXF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 08:23:05 -0500
Received: by fxm13 with SMTP id 13so3849737fxm.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 05:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=Uli5155Xc/io3DjVD8Q0u9pndfzYkG9BPYPUE3fVClg=;
        b=FRIZF0c+aernL7+bpuFMtAWu3F+DH+Ecc68qlKUycBfhtuoF9AFnpy7+A1tV8J1Z53
         0tsS814gHnlbiUr0eOLl+8mG1pKnSkvSvG7KdSSao+F8eWzPW3SVU+Mtrao57uHqAK+K
         3Zf7TpJpsMaa4lPskw0oqbXojJM4NuL3LsJLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=F/gXhPpJcb7HLEqi/0A6BpJ8xSYKkT55KStvWYAgVK5KijW4LBK1GkYYWx7NsubbZe
         cH3xVGe4CdjxcdKVj0h+oNjQv11zHQUnRzBqT14ASfCb11/h+SknJBsEdrXm+XgcHP0+
         F5/6ivuFObDBElTfWEcORVlO2Raxg+78iPW0Q=
Received: by 10.223.72.14 with SMTP id k14mr6353079faj.45.1290518583913; Tue,
 23 Nov 2010 05:23:03 -0800 (PST)
Received: by 10.223.72.206 with HTTP; Tue, 23 Nov 2010 05:22:43 -0800 (PST)
In-Reply-To: <AANLkTimdKoGHapMTrA-bf_mEyMAEiiM0ALvLbZX8QJpv@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161959>

On Tue, Nov 23, 2010 at 1:23 PM, Tarek Ziad=E9 <ziade.tarek@gmail.com> =
wrote:
> Hello,
>
> I am new to Git and I tried to run "git st"
>
> I have found one small bug: "status" is not listed in the help screen
> Git displays in that case.
>
> $ git st
> git: 'st' is not a git command. See 'git --help'.
>
> Did you mean one of these?
> =A0 =A0 =A0 =A0reset
> =A0 =A0 =A0 =A0stage
> =A0 =A0 =A0 =A0stash
>

This isn't strictly speaking a bug. Git uses Levenshtein distance
(http://en.wikipedia.org/wiki/Levenshtein_distance) to figure out what
to suggest. If any command has a sLevenshtein distance of less than 6
(given our coefficients), then all commands with that distance is
suggested. But perhaps we should do something different

But perhaps we could do better. We have some commands that are
considered more "important", ie the ones listed when doing "git help"
without "--all". "status" is one of these. Perhaps these commands
should always be included if they are below the Levenshtein distance
threshold or something?
