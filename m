From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: equal-tree-merges as way to make rebases fast-forward-able
Date: Wed, 02 Dec 2009 19:20:26 +0900
Message-ID: <20091202192026.6117@nanako3.lavabit.com>
References: <cover.1259524136.git.brlink@debian.org> <7v8wdnooza.fsf@alter.siamese.dyndns.org> <20091201071234.6117@nanako3.lavabit.com> <7vmy23bl4o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: "Bernhard R. Link" <brlink@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 11:21:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFmKQ-0001tG-S1
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 11:20:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212AbZLBKUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 05:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753210AbZLBKUd
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 05:20:33 -0500
Received: from karen.lavabit.com ([72.249.41.33]:60300 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753005AbZLBKUc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 05:20:32 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 52A9415754F;
	Wed,  2 Dec 2009 04:20:39 -0600 (CST)
Received: from 2268.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id RUOG1OEROGYA; Wed, 02 Dec 2009 04:20:39 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=eE2gLk8lUJb8GrqFNMQ5Idp/Fqbwi1Z14YadDIyM7mhx2vh/AIGWHR8qenlP7m4opscZile0LcP6VJ+usaWTshqOAdAGlWOrhEqT2KvhGON4zgoWOJ0/uepFiyIHgJg5ro11hay+H8F0IvUB+LKxqgkZ/UFGSbmOUvX+qCVyx0U=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vmy23bl4o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134324>

Quoting Junio C Hamano <gitster@pobox.com> writes:

> I think we really should start deprecating the ancient form, but the
> original sample script using this syntax from Linus was copied by many
> people and are still found everywhere, I think, and people may still
> use their scripts that were written with the ancient syntax.
>
> In any case, at least this patch will make it start behaving a bit
> more sanely.

Thank you; it fixes the bug for me. Do I have to say 

    Tested-by: Nanako Shiraishi <nanako3@lavabit.com>

to ask you to include it in the new release?

> -- >8 --
> Subject: Do not misidentify "git merge foo HEAD" as an old-style invocation
>
> This was misinterpreted as an ancient style "git merge <message> HEAD
> <commit> <commit>..." that merges one (or more) <commit> into the current
> branch and record the resulting commit with the given message.  Then a
> later sanity check found that there is no <commit> specified and gave
> a usage message.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
> diff --git a/builtin-merge.c b/builtin-merge.c
> index e95c5dc..e5cf795 100644
> --- a/builtin-merge.c
> +++ b/builtin-merge.c
> @@ -792,7 +792,7 @@ static int suggest_conflicts(void)
>  static struct commit *is_old_style_invocation(int argc, const char **argv)
>  {
>  	struct commit *second_token = NULL;
> -	if (argc > 1) {
> +	if (argc > 2) {
>  		unsigned char second_sha1[20];
>  
>  		if (get_sha1(argv[1], second_sha1))

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
