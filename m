From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: [PATCH 4/6] upload-pack: delegate rev walking in shallow fetch
 to pack-objects
Date: Wed, 28 Aug 2013 16:52:25 +0200
Message-ID: <20130828145225.GE10217@login.drsnuggles.stderr.nl>
References: <CACsJy8CDGgKftp0iBB8MYjMawKhxZ1JQ+xAYb0itpaCOjFHWxg@mail.gmail.com>
 <1376646727-22318-1-git-send-email-pclouds@gmail.com>
 <1376646727-22318-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 28 16:52:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEh6q-0005T7-TO
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 16:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861Ab3H1Owc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Aug 2013 10:52:32 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:45260 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504Ab3H1Owb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 10:52:31 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1VEh6g-00019B-4q; Wed, 28 Aug 2013 16:52:26 +0200
Received: (nullmailer pid 4410 invoked by uid 1000);
	Wed, 28 Aug 2013 14:52:26 -0000
Mail-Followup-To: Matthijs Kooijman <matthijs@stdin.nl>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <1376646727-22318-4-git-send-email-pclouds@gmail.com>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233188>

Hi Nguy,

On Fri, Aug 16, 2013 at 04:52:05PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> upload-pack has a special rev walking code for shallow recipients. It
> works almost like the similar code in pack-objects except:
>=20
> 1. in upload-pack, graft points could be added for deepening
>=20
> 2. also when the repository is deepened, the shallow point will be
>    moved further away from the tip, but the old shallow point will be
>    marked as edge to produce more efficient packs. See 6523078 (make
>    shallow repository deepening more network efficient - 2009-09-03)
>=20
> pass the file to pack-objects via --shallow-file. This will override
> $GIT_DIR/shallow and give pack-objects the exact repository shape tha=
t
> upload-pack has.
>=20
> mark edge commits by revision command arguments. Even if old shallow
> points are passed as "--not" revisions as in this patch, they will no=
t
> be picked up by mark_edges_uninteresting() because this function look=
s
> up to parents for edges, while in this case the edge is the children,
> in the opposite direction. This will be fixed in the next patch when
> all given uninteresting commits are marked as edges.
This says "the next patch" but it really refers to 6/6, not 5/6. Patch
6/6 has the same problem (it says "previous patch"). Perhaps patches 4
and 5 should just be swapped?

Gr.

Matthijs
