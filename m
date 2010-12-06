From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] describe: =?utf-8?B?RG9u4oCZ?= =?utf-8?Q?t?= look up
 commits with --exact-match
Date: Mon, 6 Dec 2010 11:47:23 -0600
Message-ID: <20101206174723.GB6272@burratino>
References: <alpine.DEB.2.02.1011171830050.14285@dr-wily.mit.edu>
 <20101203084348.GD18202@burratino>
 <alpine.DEB.2.02.1012060149550.23348@dr-wily.mit.edu>
 <20101206073214.GA3745@burratino>
 <alpine.DEB.2.02.1012061159500.23348@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Thomas Rast <trast@student.ethz.ch>
To: Anders Kaseorg <andersk@ksplice.com>
X-From: git-owner@vger.kernel.org Mon Dec 06 18:47:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPfA5-0004VG-4r
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 18:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753965Ab0LFRrd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Dec 2010 12:47:33 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36570 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336Ab0LFRrc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Dec 2010 12:47:32 -0500
Received: by vws16 with SMTP id 16so2756215vws.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 09:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=hP8mVxvognYcQjVe80ZkDwyFmvUcVe9fxqV9Jwj42Iw=;
        b=WD7T5ciByYK7BYK+dbQEtsYKA6GyUjl+8vl34h1SlXa6oriaCUXiA+v6AhZwct1cn2
         IlWur+8Aft+v1gVd+uiVFUkr2KEg6MGCIRVDL9TX/xey7k1ePK6VfOVxayUIXylKNpbB
         sa83JBei5VRRhPBBo/MFItSvPmb7hXibK6uD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=TQPPRjpJvQYA4M8qMDCtWJAzlzXqqY1LQCwiuxprj80KGkVqp7La2ANIG9CDa6VerU
         uIm3nSDzmUfimf4oOEotIp13GQr6nZdo1LPYIfFiO4axW938zPe57pdU7MO6OzcRahDJ
         Ajn2FMC49pEfvtHeGXGkwFL84tQb9I7lQrN1w=
Received: by 10.220.94.149 with SMTP id z21mr1435160vcm.153.1291657651724;
        Mon, 06 Dec 2010 09:47:31 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id y14sm575188vch.4.2010.12.06.09.47.27
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 09:47:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1012061159500.23348@dr-wily.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163003>

Anders Kaseorg wrote:

> Yeah.  Okay, I see that =E2=80=9Clookup=E2=80=9D implies unpacking, a=
s opposed to =E2=80=9Cfind=E2=80=9D,=20
> which doesn=E2=80=99t.  The important part is to avoid the find, of c=
ourse,=20
> because the I/O is expensive.
>
> Anyway, here=E2=80=99s a series with that change split out.

Thanks.

In theory finding an object would only require looking at the pack
index (and directory listings), but find_pack_entry does

		/*
		 * We are about to tell the caller where they can
		 * locate the requested object.  We better make
		 * sure the packfile is still here and can be
		 * accessed before supplying that answer, as
		 * it may have been deleted since the index
		 * was loaded!
		 */

which spoils that plan.

Your original use of the word "lookup" seemed sane, too; I was just
fishing for a more detailed explanation.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

> -- 8< --
> From 2ad1e58b8f6e9c117c77748b6e8b85227d9d5412 Mon Sep 17 00:00:00 200=
1
[...]

=46or the future: this does not follow the preferred patch format (one
patch per message, each of the form "description/---/diff").  In this
case I am guessing it won't be much trouble to massage on the
receiving end, so no terrible loss.
