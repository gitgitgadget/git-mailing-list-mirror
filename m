From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2 00/16] First class shallow clone
Date: Tue, 23 Jul 2013 00:41:35 +0100
Organization: OPDS
Message-ID: <79A9AB6FF00042D1B3E0D26B9855CCAB@PhilipOakley>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com> <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 23 01:40:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1Pii-0006xo-W8
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 01:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706Ab3GVXko convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jul 2013 19:40:44 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:24524 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751717Ab3GVXkn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jul 2013 19:40:43 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AjQOAJ/C7VFZ8YYB/2dsb2JhbABbgwM1g1qFPrdlAQMBgRUXdIIfBQEBBAEIAQEZDwEFEQUIAQEhBQYCAwUCAQMRAwECAwIFIQICFAEECBACBgcPCAYBBwsIAgECAwEMBIddAwkKCKZ3iF8NiF6BKIwCgTUgLWoNglczbgOOfYUJgW6DEop+hSaBM4FgO4EsAR8E
X-IPAS-Result: AjQOAJ/C7VFZ8YYB/2dsb2JhbABbgwM1g1qFPrdlAQMBgRUXdIIfBQEBBAEIAQEZDwEFEQUIAQEhBQYCAwUCAQMRAwECAwIFIQICFAEECBACBgcPCAYBBwsIAgECAwEMBIddAwkKCKZ3iF8NiF6BKIwCgTUgLWoNglczbgOOfYUJgW6DEop+hSaBM4FgO4EsAR8E
X-IronPort-AV: E=Sophos;i="4.89,722,1367967600"; 
   d="scan'208";a="79496716"
Received: from host-89-241-134-1.as13285.net (HELO PhilipOakley) ([89.241.134.1])
  by out1.ip07ir2.opaltelecom.net with SMTP; 23 Jul 2013 00:40:41 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231013>

=46rom: "Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy" <pclouds@gmail.com>
Subject: [PATCH v2 00/16] First class shallow clone

It's nice to see that shallow can be a first class clone.

Thinking outside the box, does this infrastructure offer the opportunit=
y=20
to maybe add a date based depth option that would establish the shallow=
=20
watermark based on date rather than count. (e.g. the "deepen" SP depth=20
could have an alternate with a leading 'T' to indicate a time limit=20
ratherv than revision count - I'm expecting such a format would be an=20
error for existing servers).

My other thought was this style of cut limit list may also allow a big=20
file limit to do a similar process of listing objects (e.g. blobs) that=
=20
are size-shallow in the repo, though it maybe a long list on some repos=
,=20
or with a small size limit.

Philip

> v2 includes:
>
> - fix Junio comments, especially the one that may lead to incomplete
>   commit islands.
> - fix send-pack setting up temporary shallow file, but never passes
>   it to index-pack/unpack-objects (also fix the tests to catch this)
> - support smart http
> - add core.noshallow for repos that wish to be always complete
> - fix locally cloning a shallow repository
> - make upload-pack pass --shallow-file to pack-objects in order to
>   remove duplicate object counting code just for shallow case.
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (16):
>  send-pack: forbid pushing from a shallow repository
>  {receive,upload}-pack: advertise shallow graft information
>  connect.c: teach get_remote_heads to parse "shallow" lines
>  Move setup_alternate_shallow and write_shallow_commits to shallow.c
>  fetch-pack: support fetching from a shallow repository
>  {send,receive}-pack: support pushing from a shallow clone
>  send-pack: support pushing to a shallow clone
>  upload-pack: let pack-objects do the object counting in shallow case
>  pack-protocol.txt: a bit about smart http
>  Add document for command arguments for supporting smart http
>  {fetch,upload}-pack: support fetching from a shallow clone via smart=
=20
> http
>  receive-pack: support pushing to a shallow clone via http
>  send-pack: support pushing from a shallow clone via http
>  git-clone.txt: remove shallow clone limitations
>  config: add core.noshallow to prevent turning a repo into a shallow=20
> one
>  clone: use git protocol for cloning shallow repo locally
>
> Documentation/config.txt                  |   5 +
> Documentation/git-clone.txt               |   7 +-
> Documentation/git-fetch-pack.txt          |  11 +-
> Documentation/git-receive-pack.txt        |  16 ++-
> Documentation/git-send-pack.txt           |   9 +-
> Documentation/git-upload-pack.txt         |  13 ++-
> Documentation/technical/pack-protocol.txt |  76 ++++++++++++-
> builtin/clone.c                           |  14 ++-
> builtin/fetch-pack.c                      |   6 +-
> builtin/receive-pack.c                    |  76 +++++++++++--
> builtin/send-pack.c                       |   7 +-
> cache.h                                   |   4 +-
> commit.h                                  |  27 +++++
> config.c                                  |   5 +
> connect.c                                 |  12 +-
> environment.c                             |   1 +
> fetch-pack.c                              |  90 ++++++---------
> fetch-pack.h                              |   1 +
> remote-curl.c                             |   4 +-
> send-pack.c                               |  57 +++++++++-
> send-pack.h                               |   4 +-
> shallow.c                                 | 147=20
> +++++++++++++++++++++++++
> t/t5530-upload-pack-error.sh              |   3 -
> t/t5536-fetch-shallow.sh (new +x)         | 141=20
> ++++++++++++++++++++++++
> t/t5537-push-shallow.sh (new +x)          | 176=20
> ++++++++++++++++++++++++++++++
> t/t5601-clone.sh                          |   7 ++
> transport.c                               |  14 ++-
> upload-pack.c                             | 132 ++++++---------------=
-
> 28 files changed, 858 insertions(+), 207 deletions(-)
> create mode 100755 t/t5536-fetch-shallow.sh
> create mode 100755 t/t5537-push-shallow.sh
>
> --=20
> 1.8.2.83.gc99314b
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> -----
> No virus found in this message.
> Checked by AVG - www.avg.com
> Version: 2013.0.3349 / Virus Database: 3204/6504 - Release Date:=20
> 07/19/13
>=20
