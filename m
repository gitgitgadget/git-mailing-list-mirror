From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: Re*: Peculiar behavior of git 1.5.6
Date: Thu, 04 Sep 2008 19:20:08 +0900
Message-ID: <20080904192008.6117@nanako3.lavabit.com>
References: <7v3akg5jul.fsf_-_@gitster.siamese.dyndns.org>
 <48BF759B.9090309@lwfinger.net> <48BF97B3.5060309@viscovery.net>
 <7vljy85mwx.fsf@gitster.siamese.dyndns.org>
 <57518fd10809040211q12d1f0ddk16f2d4273ee7d488@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: "Jonathan del Strother" <maillist@steelskies.com>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Larry Finger" <Larry.Finger@lwfinger.net>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 12:21:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbByO-0006Wb-40
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 12:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970AbYIDKUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 06:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752772AbYIDKUu
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 06:20:50 -0400
Received: from karen.lavabit.com ([72.249.41.33]:46063 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752449AbYIDKUt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 06:20:49 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id D8C8CC88B0;
	Thu,  4 Sep 2008 05:20:39 -0500 (CDT)
Received: from 7427.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id ME0A98TT02B6; Thu, 04 Sep 2008 05:20:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=YpYy/+RgDE6Y6lzMndW2jLcA9wy0wniqvIAVYk4l+95q1n7S2i+NaZG7WlL/KEMWMswzblBsfdRSWqij+Y8G1+ORin9HwANxJl4o57OKpneajLjQuIRV8SkgkRzXk3WeqaaFbYAmFZ63ssjaAjWbP4siWkkgtYpc/lc3bKc/Jro=;
  h=From:To:Cc:Date:Subject:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Quoting Junio C Hamano <gitster@pobox.com>;
In-Reply-To: <7v3akg5jul.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94920>

Quoting Junio C Hamano <gitster@pobox.com>:

> In any case, I think this should fix the unrelated issue.
>
> -- >8 --
> stash: refresh the index before deciding if the work tree is dirty
>
> Unlike the case where the user does have a real change in the work tree,
> refusing to work because of unclean stat information is not very helpful.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Acked-by: Nanako Shiraishi <nanako3@lavabit.com>

> ---
>  git-stash.sh |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git c/git-stash.sh w/git-stash.sh
> index e15c12a..d799c76 100755
> --- c/git-stash.sh
> +++ w/git-stash.sh
> @@ -39,6 +39,7 @@ clear_stash () {
>  create_stash () {
>  	stash_msg="$1"
>  
> +	git update-index -q --refresh
>  	if no_changes
>  	then
>  		exit 0
> @@ -101,6 +102,7 @@ save_stash () {
>  
>  	stash_msg="$*"
>  
> +	git update-index -q --refresh
>  	if no_changes
>  	then
>  		echo 'No local changes to save'
> @@ -150,6 +152,7 @@ show_stash () {
>  }
>  
>  apply_stash () {
> +	git update-index -q --refresh &&
>  	git diff-files --quiet --ignore-submodules ||
>  		die 'Cannot restore on top of a dirty state'
>  

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
