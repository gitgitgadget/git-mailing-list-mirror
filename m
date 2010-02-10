From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@fzi.de>
Subject: Re: [PATCH] blame: allow -L n,m to have an m bigger than the
	file's line count
Date: Wed, 10 Feb 2010 13:42:38 +0100
Message-ID: <20100210124238.GA31978@neumann>
References: <1265786864-5460-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 13:42:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfBu3-000143-Hj
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 13:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005Ab0BJMmm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2010 07:42:42 -0500
Received: from francis.fzi.de ([141.21.7.5]:19934 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751709Ab0BJMmm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 07:42:42 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 10 Feb 2010 13:42:38 +0100
Content-Disposition: inline
In-Reply-To: <1265786864-5460-1-git-send-email-bebarino@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 10 Feb 2010 12:42:38.0607 (UTC) FILETIME=[873551F0:01CAAA4E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139509>

Hi Stephen,


On Tue, Feb 09, 2010 at 11:27:44PM -0800, Stephen Boyd wrote:
> Sometimes I want to blame a file starting at some point and ending at
> the end of the file. In my haste I'll write something like this:
>=20
> $ git blame -L5,2342343 -- builtin-blame.c
>=20
> and be greeted by a die message telling me that my end range is great=
er
> than the number of lines in the file. Obviously I can do:
>=20
> $ git blame -L5, -- builtin-blame.c
>=20
> and get what I want but that isn't very discoverable. If the range is
> greater than the number of lines just truncate the range to go up to
> the end of the file.
>=20
> Update the docs to more accurately reflect the defaults for n and m t=
oo.
>=20
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---
>=20
> I realize this is late in the game for 1.7.0 so I'll resend if this
> isn't picked up.
>=20
>  Documentation/blame-options.txt |    4 +++-
>  builtin-blame.c                 |    4 +++-
>  t/t8003-blame.sh                |    4 ++--
>  3 files changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/blame-options.txt b/Documentation/blame-op=
tions.txt
> index 4833cac..620660d 100644
> --- a/Documentation/blame-options.txt
> +++ b/Documentation/blame-options.txt
> @@ -9,7 +9,7 @@
>  --show-stats::
>  	Include additional statistics at the end of blame output.
> =20
> --L <start>,<end>::
> +-L [<start>],[<end>]::
>  	Annotate only the given line range.  <start> and <end> can take
>  	one of these forms:
> =20
> @@ -31,6 +31,8 @@ starting at the line given by <start>.
>  This is only valid for <end> and will specify a number
>  of lines before or after the line given by <start>.
>  +
> +Note: if <start> is not given it defaults to 1 and if <end> is not g=
iven it
> +defaults to the number of lines in the file.
> =20
>  -l::
>  	Show long rev (Default: off).

I agree that its too late for the behavioral change, but IMHO the
documentation update part can be considered as a bugfix, and as such
it could perhaps be included in 1.7.0.  (I never knew that <start> or
<end> can be omitted...  so thanks for the hint anyway)


Best,
G=E1bor
