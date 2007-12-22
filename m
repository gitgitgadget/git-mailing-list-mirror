From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH v2] Emit helpful status for accidental "git stash" save
Date: Sat, 22 Dec 2007 19:44:15 +0100
Message-ID: <E8ED8DFC-9DD9-4A5C-A344-5279CEE15458@wincent.com>
References: <7vmys2ya0l.fsf@gitster.siamese.dyndns.org> <1198344685-24156-1-git-send-email-win@wincent.com> <7vabo2y5la.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 19:45:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J69Lk-0006QY-GC
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 19:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115AbXLVSox convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Dec 2007 13:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752696AbXLVSox
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 13:44:53 -0500
Received: from wincent.com ([72.3.236.74]:45673 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440AbXLVSow convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Dec 2007 13:44:52 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBMIiGqk032036;
	Sat, 22 Dec 2007 12:44:17 -0600
In-Reply-To: <7vabo2y5la.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69153>

El 22/12/2007, a las 18:58, Junio C Hamano escribi=F3:

> Wincent Colaiuta <win@wincent.com> writes:
>
>> Something like this then?
>
> Sure, even like this.
>
> git-stash.sh |    6 ++++--
> 1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index f16fd9c..ade300c 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -99,7 +99,7 @@ save_stash () {
>
> 	git update-ref -m "$stash_msg" $ref_stash $w_commit ||
> 		die "Cannot save the current status"
> -	printf >&2 'Saved "%s"\n' "$stash_msg"
> +	printf >&2 'Saved working directory and index state "%s"\n' =20
> "$stash_msg"
> }
>
> have_stash () {
> @@ -228,7 +228,9 @@ create)
> *)
> 	if test $# -eq 0
> 	then
> -		save_stash && git-reset --hard
> +		save_stash &&
> +		echo >&2 '(To restore them type "git stash apply")' &&
> +		git-reset --hard
> 	else
> 		usage
> 	fi

Preserves the behaviour while avoiding the need for the creation of =20
the ARGC variable, so if you prefer this solution then it seems fine =20
by me.

Cheers,
Wincent
