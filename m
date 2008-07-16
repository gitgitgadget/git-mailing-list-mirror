From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] Reformat "your branch has diverged..." lines to reduce line length.
Date: Wed, 16 Jul 2008 16:27:15 -0400
Message-ID: <32541b130807161327k17f3a58ay5ab2da75963a2d50@mail.gmail.com>
References: <1216235967-9510-1-git-send-email-apenwarr@gmail.com>
	 <7v4p6pr4ob.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 22:28:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJDbl-0006Xn-CS
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 22:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589AbYGPU1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 16:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753646AbYGPU1R
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 16:27:17 -0400
Received: from hs-out-0708.google.com ([64.233.178.248]:21931 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064AbYGPU1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 16:27:16 -0400
Received: by hs-out-0708.google.com with SMTP id 4so1531186hsl.5
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 13:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=STJp6UEd6r2D90e4nVzm1fUnNUReBJ32lY2GyKYXfbQ=;
        b=ElhzDhvdUDULPfRd/nlSZPrVRstrEwKBFczmhD2GIJ7agwF8KHrPYxTxVvfRkw6eKJ
         xN9sZOE3w/GluTWSUiBAaCvNUaf2ZBPcZcQ3PJWOejn6/Kt2v4XGbV7irkuGYqK8P59d
         QJwvKBQf7DYQg/2GeskSmEQkWi3O78tsiqPgY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=o0xWWbtlLna3JJkLEJ/eFqleZW5MFTDYucX8Pl0FeDFi3U5c8TjnB1EUM+c12tMhXP
         ZtmLp58GVuggYxZvK39jQnbp+mPg+ztRB+7s9ILswmjIE24NNiTH5gbLHocNPXogatvD
         GbWdFmfyI9P0rMbnu/Moxs39CULfQoBynpq5s=
Received: by 10.100.33.13 with SMTP id g13mr2759668ang.96.1216240035274;
        Wed, 16 Jul 2008 13:27:15 -0700 (PDT)
Received: by 10.100.8.19 with HTTP; Wed, 16 Jul 2008 13:27:15 -0700 (PDT)
In-Reply-To: <7v4p6pr4ob.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88744>

On 7/16/08, Junio C Hamano <gitster@pobox.com> wrote:
> Avery Pennarun <apenwarr@gmail.com> writes:
>  >       if (!num_theirs)
>  > -             strbuf_addf(sb, "Your branch is ahead of the tracked%s branch '%s' "
>  > +             strbuf_addf(sb, "Your branch is ahead of the tracked%s branch '%s'\n"
>  >                           "by %d commit%s.\n",
>
>  I wonder if a simple "s/of the tracked%s branch //" is better for this
>  kind of thing.  If the message says 'origin/master', you know it is a
>  tracked remote branch anyway, don't you?

Personally, I would be fine with shorter messages; this doesn't seem
the best time to
report the name of the tracked branch anyhow.  I use 80x24 terminals
too most of the time.

However, I didn't write the original patch either, and I recall that
this feature was so popular that it actually resulted in a list thread
complimenting it, so I was hesitant to change it too much :)

>         Your branch is ahead of 'origin/add-chickens2' by 21 commits.
>
>         Your branch is behind 'origin/add-chickens2' by 1 commit.
>
>         Your branch and 'origin/add-chickens2' have diverged, and have
>         21 and 1 different commit(s) each, respectively.
>
>  I moved "respectively" so that the variable parts will come close to the
>  beginning of physical line.

Well, the fact that the number of commits is "variable" isn't so
important, unless you start diverging by 1e9 commits or something :)
It might be nice to minimize the amount of static text on the line
containing the branch name, though.  Your rephrasing would allow us to
go as far as:

    Your branch and 'origin/add-chickens2'
    have diverged, and have 21 and 1 different commit(s) each, respectively.

Which looks a little imbalanced, but works with long branch names.

Alternatively, your rephrasing above made me think of the idea of just
printing *both* of the first two messages in the "diverging" case.
Depending how you think of it, that would be either more clear or less
clear.  It's actually easier to parse the two short sentences than the
long one.

Please let me know if you want me to resubmit the patch with your
suggestions or whether you'll handle it.  I'm still a little vague on
the exact patch approval process.

Have fun,

Avery
