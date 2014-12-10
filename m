From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 23/23] untracked cache: guard and disable on system changes
Date: Wed, 10 Dec 2014 19:22:14 +0700
Message-ID: <CACsJy8BPzcAPJZG4=+mt=LmhhheJjXkfD2+znMjBbjbB9mODDQ@mail.gmail.com>
References: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
 <1418047507-22892-25-git-send-email-pclouds@gmail.com> <20141209100430.GC76457@vauxhall.crustytoothpaste.net>
 <CACsJy8A5-smRXN0k5TK8uPg4-j-Z83KWLNSO_w-eFivTNB_www@mail.gmail.com> <5487D543.7060801@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Dec 10 13:22:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XygI7-0008Ni-Kx
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 13:22:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbaLJMWr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Dec 2014 07:22:47 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:55831 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbaLJMWq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2014 07:22:46 -0500
Received: by mail-ie0-f179.google.com with SMTP id rp18so2520716iec.38
        for <git@vger.kernel.org>; Wed, 10 Dec 2014 04:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=4h/ky75GgupAtGTKuLorQENYwJOkfN+C6tjh+kA3er8=;
        b=shfTXUv0wy5gB9oyso9OAJohiEbHEnj0suy1qIOa/ODYiHonC+CYzzCzDJxe5JyFyh
         zp1QEI0ffKT5jRHvYxw9AMieAtPHMnQPwe4yv32VIFLxsBuAGNbrgQdX9csePdUkn8Un
         LXTXovC3Ir5tTrVZpkFtxGIJhDPHhwdOYzgMo9sknCRLrMxijxyNpwNZf2ssRg6Nrupy
         3PNbwpg0wgjbJWeaA8c9zwaIkK4EAsWmLYoPgAy4j0uywvPX6tLW4jtO2S8cO6nWXBFw
         jEc4AMskNbJtZ1VxoxY0E3nVxuXOvHDwoU7YobdZYHDl374XfCtnCvGA37wOPmJStXtk
         VU7g==
X-Received: by 10.43.120.69 with SMTP id fx5mr6412783icc.45.1418214165917;
 Wed, 10 Dec 2014 04:22:45 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Wed, 10 Dec 2014 04:22:14 -0800 (PST)
In-Reply-To: <5487D543.7060801@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261210>

On Wed, Dec 10, 2014 at 12:08 PM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
> That opens another question:
> How flexible/extensible/self-describing is the format of the UNTR ext=
ension
> ?
> If we drop the OS name & root dir check because it disallows network =
use,
> but later add a better method to verify that the underlying chain
> local OS - network - remote OS-remote FS is OK,
> do we need to change the file format of UNTR ?
> If yes, can old clients read the new format and vice versa?
> Do we need a version information of some kind, or does the
> old client skip unknown entries like we do with extensions in the ind=
ex ?

The way index extensions are done so far, there's no actual versioning
inside an extension.Once an extension is out, its format is set in
stone. If you change your mind, you make a new extension (with a
different signature), so signatures are sort of "version". Code is
shared mostly so it should not be a problem. Old clients don't
recognize new extensions, so they drop them. New clients either stick
to old extensions or convert them to new ones. This is all local
matters, so I don't think we need to worry too much.
--=20
Duy
