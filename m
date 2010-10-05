From: =?ISO-8859-1?Q?Gustav_H=E5llberg?= <gustav@gmail.com>
Subject: Re: [stgit PATCH] commands.{new,rename}: verify patch names
Date: Tue, 5 Oct 2010 14:44:43 +0200
Message-ID: <AANLkTin9PyfY+-1=mJKMZa2FJ5YC2D27iPtiocCWY+eP@mail.gmail.com>
References: <20101005114541.15037.53617.stgit@woodpecker.blarg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Max Kellermann <max@duempel.org>
X-From: git-owner@vger.kernel.org Tue Oct 05 14:44:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P36t1-0000xa-0W
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 14:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264Ab0JEMop convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 08:44:45 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56401 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024Ab0JEMoo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 08:44:44 -0400
Received: by gye5 with SMTP id 5so1861307gye.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 05:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EQJJFoo4o7J2GElusNCEGKe+IHh9KC5JgP5dM1bIyl8=;
        b=k10mGljX6YRKuVico1Cn5Z2L2ewbPgrde4PjxwJWGJtFw81MXGkNdV0pJ5CKxvWBMA
         uEKmrYVruXj+Ybd0gnlSrTgVLgQmmJ8o5mGm4R+GomPWwizD2lTM1qqepRfAkqoWf1/k
         YEn0jgEzv6VHVcQ9+q/bh4UN1Z2CsMIOum1Qg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Pw2ymrWCeINGzA0SB/Ym5VmF9o90QHyFuSKdwrLO0h6oqrGaH8YJLxfiOlyEHcSNrg
         97ko1gkXS4al3kKDuFIPzZXwX135yNw2ayUDGPnMFliV7UzUE+SxglneoDD4iI70yuGD
         +uLOn0Itjy1ZlBUOWai3/UnA6leo4JDGzZTG8=
Received: by 10.236.95.15 with SMTP id o15mr10764830yhf.48.1286282683890; Tue,
 05 Oct 2010 05:44:43 -0700 (PDT)
Received: by 10.220.171.8 with HTTP; Tue, 5 Oct 2010 05:44:43 -0700 (PDT)
In-Reply-To: <20101005114541.15037.53617.stgit@woodpecker.blarg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158192>

On Tue, Oct 5, 2010 at 1:45 PM, Max Kellermann <max@duempel.org> wrote:
> +def check_patch_name(name):
> + =A0 =A0"""Checks if the specified name is a valid patch name. For
> + =A0 =A0technical reasons, we cannot allow a slash and other charact=
ers."""
> + =A0 =A0return len(name) > 0 and name[0] !=3D '.' and re.search(r'[\=
x00-\x20]', name) is None

I don't quite understand how the above would filter out slashes.

There are also other types of names that won't work correctly in git,
such as names starting with (double?) hyphens.

Does anyone know if it's explicitly documented anywhere which types of
names are (meant to be) allowed for git refs?
Note that you can create refs with names that don't actually work
correctly; e.g.,

 sh$ git tag -- --foo
 sh$ git rev-parse --foo
 <failure>

- Gustav
