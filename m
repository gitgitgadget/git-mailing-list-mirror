From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v3 00/27] Clean up update-refs --stdin and implement ref_transaction
Date: Fri, 11 Apr 2014 12:57:42 -0700
Message-ID: <CAL=YDWkjNm-pt2dUsg3Dbtbb1Xi2v3XAP8231g1bxsWF6LHRhQ@mail.gmail.com>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Apr 11 21:57:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYhaC-0001Oc-8j
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 21:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391AbaDKT5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 15:57:44 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:43956 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbaDKT5n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 15:57:43 -0400
Received: by mail-vc0-f174.google.com with SMTP id ld13so5130593vcb.5
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 12:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vdbvrUn/yC55t7yingrI+m+vFJuJ94YiNftjPfmYqWo=;
        b=ejmdxS2mArlGL0Wr2Dt5EJdYhctA6d81jxHcvZrdq3QKNZfGcZ3iLE5CGRDRiCUhHT
         IQ77SnEAngbg1Rb/GbPiRlLjJFN+MIo2szYYgoDm4t0ZAGT5+AzGnH4Z/PFvOcjrsTtO
         zdmsmFMMsz9njOWPNRr12t9grUqjyEtCxBBnQ7mzrl/bOBWnnjf9SZt45Kpb9dqsblb5
         nXXNMIYXb3kl2Srbgi21iYlzDQqcCvv3xx+z7gGNrVisl7tjsmx/c+5HTNCvlDhS2azF
         0QBuSWbp0/Ch7x7zJQlbjPh2aI2NupLZ5gPJpA6+jMCY4Rd9aRBI3Oigq2lJsM/xcz5o
         Lu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vdbvrUn/yC55t7yingrI+m+vFJuJ94YiNftjPfmYqWo=;
        b=G7sNe0w/ouUWVaP2FICD4J/GHvVi3HliDDvoCjuZOB0hUHzOhoxqteko13sz8mD6u8
         dgBTjbzoDVLySoAtfc786ZBZ5wfV8928XPlnUmd1lc0VkHYQScF9ye0W2VoBj17YV5Ts
         eVyyVg0nF7dPjJCN3IHh9nAOn8kxjh3MzgTObZSeeoWoLMERYRg4MM0Q3rCK0I9yGfW5
         wCnqJfpAZ393dfB2pjqfDsfBNSlqdhE1iuR7FxA5y7UqAvMe1xt6wP1Hfrt+IOV59NHE
         6gMOFqVDTuP1iMjIOD1KER/W/XVy28BwBGhKcGZLgFYKGzOB093BOpNJ2c/bOOzZPJYM
         gTKg==
X-Gm-Message-State: ALoCoQnr8u2MlNh9zPF5/+eQiZs55MTl6jFEIQumfUwAHsXsP82s8IL/u733Ao/Pg5ifvBmN7MhS0kj8RP35FiUIWhG87QYkDudWnCpE9ciGHhwYiSe/XGwp6psbrvgqILoqksbVB98A+/Yf/CzZtkGn1z2oiNzPBUMM1o9dxIjsYYIyrsDviGlL+3b1CeEXmOybxt9PI0Gu
X-Received: by 10.220.190.197 with SMTP id dj5mr10315294vcb.19.1397246263025;
 Fri, 11 Apr 2014 12:57:43 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Fri, 11 Apr 2014 12:57:42 -0700 (PDT)
In-Reply-To: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246139>

Nice.

Once this is in I can add transactional support to receive-pack.

On Mon, Apr 7, 2014 at 6:47 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Here is v3.  It is also available on GitHub [1].
>
> Thanks to Junio and Brad for their comments about v2.  I think I have
> addressed all of your comments (except for Junio's regrets that the
> series didn't include a transactional receive-pack).
>
> See the mailing list threads about v1 [2] and v2 [3] and the
> longer-term goals of this campaign [4].
>
> Changes since v2:
>
> * Rebased to current master (there were no conflicts)
>
> * Don't allow ref_transation_create() with new_sha1 set to zeros.
>
> * Don't allow ref_transation_delete() with old_sha1 set to zeros.
>
> * Fixed subject lines to use lower-case after the colon.
>
> * Expanded a few commit messages, fixed a comment, and removed some
>   "squash" detritus in a commit message.
>
> Cheers,
> Michael
>
> [1] https://github.com/mhagger/git, branch ref-transactions
> [2] http://thread.gmane.org/gmane.comp.version-control.git/243731
> [3] http://thread.gmane.org/gmane.comp.version-control.git/244857
> [4] http://article.gmane.org/gmane.comp.version-control.git/243726
>
> Michael Haggerty (27):
>   t1400: fix name and expected result of one test
>   t1400: provide more usual input to the command
>   parse_arg(): really test that argument is properly terminated
>   t1400: add some more tests involving quoted arguments
>   refs.h: rename the action_on_err constants
>   update_refs(): fix constness
>   update-ref --stdin: read the whole input at once
>   parse_cmd_verify(): copy old_sha1 instead of evaluating <oldvalue>
>     twice
>   update-ref.c: extract a new function, parse_refname()
>   update-ref --stdin: improve error messages for invalid values
>   update-ref --stdin: make error messages more consistent
>   update-ref --stdin: simplify error messages for missing oldvalues
>   t1400: test that stdin -z update treats empty <newvalue> as zeros
>   update-ref.c: extract a new function, parse_next_sha1()
>   update-ref --stdin -z: deprecate interpreting the empty string as
>     zeros
>   t1400: test one mistake at a time
>   update-ref --stdin: improve the error message for unexpected EOF
>   update-ref --stdin: harmonize error messages
>   refs: add a concept of a reference transaction
>   update-ref --stdin: reimplement using reference transactions
>   refs: remove API function update_refs()
>   struct ref_update: rename field "ref_name" to "refname"
>   struct ref_update: store refname as a FLEX_ARRAY
>   ref_transaction_commit(): simplify code using temporary variables
>   struct ref_update: add a lock field
>   struct ref_update: add a type field
>   ref_transaction_commit(): work with transaction->updates in place
>
>  Documentation/git-update-ref.txt       |  18 +-
>  builtin/checkout.c                     |   2 +-
>  builtin/clone.c                        |   9 +-
>  builtin/merge.c                        |   6 +-
>  builtin/notes.c                        |   6 +-
>  builtin/reset.c                        |   6 +-
>  builtin/update-ref.c                   | 425 ++++++++++++++++++++-------------
>  contrib/examples/builtin-fetch--tool.c |   3 +-
>  notes-cache.c                          |   2 +-
>  notes-utils.c                          |   3 +-
>  refs.c                                 | 195 +++++++++++----
>  refs.h                                 |  94 ++++++--
>  t/t1400-update-ref.sh                  | 100 +++++---
>  13 files changed, 585 insertions(+), 284 deletions(-)
>
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
