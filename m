From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Add option to git-commit to allow empty log messages
Date: Mon, 5 Apr 2010 13:11:52 -0500
Message-ID: <20100405181152.GA32188@progeny.tock>
References: <z2r51dd1af81004031506pc9ac1840ie9953ae6df91d01b@mail.gmail.com>
 <1270392557-26538-1-git-send-email-avarab@gmail.com>
 <20100404224324.GB12655@gmail.com>
 <y2j51dd1af81004041653g9a09915el60104c575dcf6481@mail.gmail.com>
 <7vy6h2wsvg.fsf@alter.siamese.dyndns.org>
 <buor5mu7acd.fsf@dhlpc061.dev.necel.com>
 <20100405055139.GA28730@coredump.intra.peff.net>
 <o2h51dd1af81004050550v9427b9flfb13a9e1ad4056a@mail.gmail.com>
 <20100405175822.GA32083@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Miles Bader <miles@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:11:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nyqlp-0001Ro-6E
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728Ab0DESLa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:11:30 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48615 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654Ab0DESL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:11:27 -0400
Received: by pwj9 with SMTP id 9so499993pwj.19
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=C999UAT4lm9Ije+8LsqqYAVzSla2DLa7tgAtf2D4Nzc=;
        b=ZXHCHEFoj2luhS8fEZlSqblGyrdlkZ2+0CPwSht/MwQRYj3zwfn11jQpNUUXK0Z7hU
         NJSrOPzZvRvpRu5sYuDU0DEe0nf92BBZxVahQf8YagVetLk++oqZOUt0yMdCSSUragPv
         zgJ/6WhZfdJKbaEhjEd4rG0XMOA2R9o6tKWbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=nIy4+InHW1VoiFTzTSnqLKDH2AmvUexHW6UqfUKrgc0pmxSiz74TkR3S1waqHPjB5b
         nMYevuEusQmh6cuSvExRlqZmeNgGFk48ZVkATLYtk1i9D1hVuh4cSEwuoQ2TcAyd1/Aj
         LS62hCAkV8jolrgu0bQ/PqgyWrDm3wwt0SHMg=
Received: by 10.114.31.19 with SMTP id e19mr4942876wae.10.1270491086619;
        Mon, 05 Apr 2010 11:11:26 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm3739521iwn.2.2010.04.05.11.11.25
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:11:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100405175822.GA32083@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143997>

Jonathan Nieder wrote:

> 	parent=3DHEAD && : or whatever &&
> 	tree=3D$(git write-tree) &&
> 	printf "%s\n" message |
> 	commit=3D$(git commit-tree "$tree" -p "$parent") &&
> 	git update-ref refs/heads/somebranch "$commit"

I rearranged this example the last minute and broke it.  You might
say this proves the opposite of my point, though I don=E2=80=99t think =
that
would be warranted.  Anyway, to feed the message into =E2=80=98git
commit-tree=E2=80=99 standard input, the relevant part of the example s=
hould
have read as follows:

commit=3D$(
	printf "%s\n" message |
	git commit-tree "$tree" -p "$parent"
)

Incidentally, outside of the user manual and contrib/examples/ in the
sources, the git documentation does not have many examples like this
to point to, which is too bad.

Sorry for the confusion,
Jonathan
