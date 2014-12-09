From: =?ISO-8859-1?Q?S=E9rgio?= Basto <sergio@serjux.com>
Subject: Re: [PATCH v2] doc: make clear --assume-unchanged's user contract
Date: Tue, 09 Dec 2014 03:43:56 +0000
Message-ID: <1418096636.19104.31.camel@segulix>
References: <1417878270-4364-1-git-send-email-philipoakley@iee.org>
	 <1417878270-4364-2-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Dec 09 04:44:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyBiY-0001gU-Nd
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 04:44:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754932AbaLIDoC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Dec 2014 22:44:02 -0500
Received: from host1.easyho.st ([62.210.60.225]:33063 "EHLO host1.easyho.st"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752197AbaLIDoA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 22:44:00 -0500
Received: from [188.250.193.97] (port=63556 helo=[192.168.1.67])
	by host1.easyho.st with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
	(Exim 4.84)
	(envelope-from <sergio@serjux.com>)
	id 1XyBiO-003WBS-Li; Tue, 09 Dec 2014 03:43:58 +0000
In-Reply-To: <1417878270-4364-2-git-send-email-philipoakley@iee.org>
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host1.easyho.st
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - serjux.com
X-Get-Message-Sender-Via: host1.easyho.st: authenticated_id: sergio@serjux.com
X-From-Rewrite: unmodified, already matched
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261106>

On S=E1b, 2014-12-06 at 15:04 +0000, Philip Oakley wrote:=20
> Many users misunderstand the --assume-unchanged contract, believing
> it means Git won't look at the flagged file.
>=20
> Be explicit that the --assume-unchanged contract is by the user that
> they will NOT change the file so that Git does not need to look (and
> expend, for example, lstat(2) cycles)
>=20
> Mentioning "Git stops checking" does not help the reader, as it is
> only one possible consequence of what that assumption allows Git to
> do, but
>=20
>    (1) there are things other than "stop checking" that Git can do
>        based on that assumption; and
>    (2) Git is not obliged to stop checking; it merely is allowed to.
>=20
> Also, this is a single flag bit, correct the plural to singular, and
> the verb, accordingly.
>=20
> Drop the stale and incorrect information about "poor-man's ignore",
> which is not what this flag bit is about at all.
>=20
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
>  Documentation/git-update-index.txt | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>=20
> diff --git a/Documentation/git-update-index.txt b/Documentation/git-u=
pdate-index.txt
> index e0a8702..da1ccbc 100644
> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -78,20 +78,18 @@ OPTIONS
>          Set the execute permissions on the updated files.
> =20
>  --[no-]assume-unchanged::
> -	When these flags are specified, the object names recorded
> -	for the paths are not updated.  Instead, these options
> -	set and unset the "assume unchanged" bit for the
> -	paths.  When the "assume unchanged" bit is on, Git stops
> -	checking the working tree files for possible
> -	modifications, so you need to manually unset the bit to
> -	tell Git when you change the working tree file. This is
> +	When this flag is specified, the object names recorded
> +	for the paths are not updated.  Instead, this option
> +	sets/unsets the "assume unchanged" bit for the
> +	paths.  When the "assume unchanged" bit is on, the user
> +	promises not to change the file and allows Git to assume
> +	that the working tree file matches what is recorded in
> +	the index.  If you want to change the working tree file,
> +	you need to unset the bit to tell Git.  This is
>  	sometimes helpful when working with a big project on a
>  	filesystem that has very slow lstat(2) system call
>  	(e.g. cifs).
>  +
> -This option can be also used as a coarse file-level mechanism
> -to ignore uncommitted changes in tracked files (akin to what
> -`.gitignore` does for untracked files).
>  Git will fail (gracefully) in case it needs to modify this file
>  in the index e.g. when merging in a commit;
>  thus, in case the assumed-untracked file is changed upstream,

I don't understand why you insist that we have a contract,=20
when :=20
"git diff .", "git diff -a" and "git commit -a" have a different
behavior of "git commit ." , this is not about any contract this is
about coherency and be user friendly .=20

At least if you want keep things like that, wrote in doc, clearly, that
assume-unchanged flag *is not*, to git ignoring changes in tracked file=
s
and currently not ignore files for git commit <path> and may not work i=
n
other cases .=20

Also don't understand why --assumed-untracked shouldn't deal with
changed files instead fallback in "the user promises not to change the
file" and sometimes works others not.=20

Also if this is the contract when a file is different from commit,
should warning the user that is not in contract (modify files that are
assumed-untracked )=20


Thanks,=20
--=20
S=E9rgio M. B.
