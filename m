From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 04/16] ref-filter: modify "%(objectname:short)" to take length
Date: Tue, 15 Mar 2016 15:11:55 -0700
Message-ID: <CA+P7+xofBUBOWLMdYi7V7Np00V0e7kcBgDDgjT-g4dnk2ag22g@mail.gmail.com>
References: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com> <1458060436-1215-5-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 23:12:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afxCd-00021F-G5
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 23:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933216AbcCOWM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 18:12:27 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:34307 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932972AbcCOWMP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 18:12:15 -0400
Received: by mail-io0-f174.google.com with SMTP id m184so41862975iof.1
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 15:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SS3hTOyFjaOe5TVm8D4mnrisq3uvW7hMLHaTobMRWxw=;
        b=TFPUsGD251QZnF67qAYKta2q3/6XGWOABw4iyC17ANNNhkOQ+/lB0YrmMuPUd0nqvr
         qRfNJ/oQ7LOvfD3wcXGr8IihNcVirFfH3M7NYy+0uUsYQLT8SZ7JCjSn9lP5a9eStVS1
         JXLMXXbJjpEo7GA/PUyV1tdmcj3FfeNwfage8lpNNyrxr+vx/VYenOemBLDdZnzRlBA2
         IcyEFx6F+pfbGFx+vxOiKuyCd1oUzZnbodKHnxpomqNp3jCmEfCdHM23Ox7uZuSeynCy
         pf+psPGZjxqYOpkO2Tsr/TLL9fWjrW9xmJ0/xdGXCmUwmahSOKqw79O0/CJrhqQawxT+
         nFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SS3hTOyFjaOe5TVm8D4mnrisq3uvW7hMLHaTobMRWxw=;
        b=mIYmvE9RlD1mhDOfS9qb9FgyEqLIn56HJzgENZS1Cr6JtEdDWlI1eXcau6rps/c1XD
         oDuBIiDdFQkc60xpBWGkoi/ZDpT6yHsBowK6nMPqp/+0oID8hL+hpl2BOLZvSHFMxWNm
         memHWYMrC8or8plQ428ODs92z9UXfZhq4iVWVM9H3yaHFy94LhMxdM5f571wE2D1adT8
         pvuc/oK+/i0a3/OCrkT8bHj0RT3u0ZHwOX7+Z7QUu5aNsJk5j+UFrTbJB+YdimgPmW9c
         Qtl3l36fIBmhRgkfKVX/gH3aNM9DKiP/CTj8MrYVIL00hwyKNUtds7HOagwaoNsqN2JJ
         3VUw==
X-Gm-Message-State: AD7BkJKkoC5WqnLCHVJXO/JpiOXSXevI+NmgcY9XeQCD278H0qTTB2VkEvMrWGKQu0jnnRqYshqjNmwd2feQFg==
X-Received: by 10.107.170.6 with SMTP id t6mr1226885ioe.71.1458079934683; Tue,
 15 Mar 2016 15:12:14 -0700 (PDT)
Received: by 10.107.10.202 with HTTP; Tue, 15 Mar 2016 15:11:55 -0700 (PDT)
In-Reply-To: <1458060436-1215-5-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288926>

On Tue, Mar 15, 2016 at 9:47 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Add support for %(objectname:short=<length>) which would print the
> abbreviated unique objectname of given length. When no length is
> specified 7 is used. The minimum length is 'MINIMUM_ABBREV'.
>

Isn't the default abbreviation value used here, not hard coded to 7?
Thus user can configure this?

Description should also mention that length may be exceeded if it is
not long enough to be a unique identifier.

> Add tests and documentation for the same.
>

Also I didn't see any update to the documentation here..

> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  ref-filter.c            | 25 +++++++++++++++++++------
>  t/t6300-for-each-ref.sh | 10 ++++++++++
>  2 files changed, 29 insertions(+), 6 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 857a8b5..17f781d 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -55,7 +55,10 @@ static struct used_atom {
>                         const char *if_equals,
>                                 *not_equals;
>                 } if_then_else;
> -               enum { O_FULL, O_SHORT } objectname;
> +               struct {
> +                       enum { O_FULL, O_LENGTH, O_SHORT } option;
> +                       unsigned int length;
> +               } objectname;
>         } u;
>  } *used_atom;
>  static int used_atom_cnt, need_tagged, need_symref;
> @@ -118,10 +121,17 @@ static void contents_atom_parser(struct used_atom *atom, const char *arg)
>  static void objectname_atom_parser(struct used_atom *atom, const char *arg)
>  {
>         if (!arg)
> -               atom->u.objectname = O_FULL;
> +               atom->u.objectname.option = O_FULL;
>         else if (!strcmp(arg, "short"))
> -               atom->u.objectname = O_SHORT;
> -       else
> +               atom->u.objectname.option = O_SHORT;
> +       else if (skip_prefix(arg, "short=", &arg)) {
> +               atom->u.contents.option = O_LENGTH;
> +               if (strtoul_ui(arg, 10, &atom->u.objectname.length) ||
> +                   atom->u.objectname.length == 0)
> +                       die(_("positive value expected objectname:short=%s"), arg);
> +               if (atom->u.objectname.length < MINIMUM_ABBREV)
> +                       atom->u.objectname.length = MINIMUM_ABBREV;

Should this error instead of accepting and upgrading it to the minimum?

> +       } else
>                 die(_("unrecognized %%(objectname) argument: %s"), arg);
>  }
>
> @@ -591,12 +601,15 @@ static int grab_objectname(const char *name, const unsigned char *sha1,
>                            struct atom_value *v, struct used_atom *atom)
>  {
>         if (starts_with(name, "objectname")) {
> -               if (atom->u.objectname == O_SHORT) {
> +               if (atom->u.objectname.option == O_SHORT) {
>                         v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));

Yes, here we are using DEFAULT_ABBREV, so you should mention that
instead of using 7 in the commit message.

>                         return 1;
> -               } else if (atom->u.objectname == O_FULL) {
> +               } else if (atom->u.objectname.option == O_FULL) {
>                         v->s = xstrdup(sha1_to_hex(sha1));
>                         return 1;
> +               } else if (atom->u.objectname.option == O_LENGTH) {
> +                       v->s = xstrdup(find_unique_abbrev(sha1, atom->u.objectname.length));
> +                       return 1;
>                 } else
>                         die("BUG: unknown %%(objectname) option");
>         }
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 19a2823..2be0a3f 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -60,6 +60,8 @@ test_atom head objecttype commit
>  test_atom head objectsize 171
>  test_atom head objectname $(git rev-parse refs/heads/master)
>  test_atom head objectname:short $(git rev-parse --short refs/heads/master)
> +test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)
> +test_atom head objectname:short=10 $(git rev-parse --short=10 refs/heads/master)
>  test_atom head tree $(git rev-parse refs/heads/master^{tree})
>  test_atom head parent ''
>  test_atom head numparent 0
> @@ -99,6 +101,8 @@ test_atom tag objecttype tag
>  test_atom tag objectsize 154
>  test_atom tag objectname $(git rev-parse refs/tags/testtag)
>  test_atom tag objectname:short $(git rev-parse --short refs/tags/testtag)
> +test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)
> +test_atom head objectname:short=10 $(git rev-parse --short=10 refs/heads/master)
>  test_atom tag tree ''
>  test_atom tag parent ''
>  test_atom tag numparent ''
> @@ -164,6 +168,12 @@ test_expect_success 'Check invalid format specifiers are errors' '
>         test_must_fail git for-each-ref --format="%(authordate:INVALID)" refs/heads
>  '
>
> +test_expect_success 'arguments to %(objectname:short=) must be positive integers' '
> +       test_must_fail git for-each-ref --format="%(objectname:short=0)" &&
> +       test_must_fail git for-each-ref --format="%(objectname:short=-1)" &&
> +       test_must_fail git for-each-ref --format="%(objectname:short=foo)"
> +'
> +
>  test_date () {
>         f=$1 &&
>         committer_date=$2 &&
> --
> 2.7.3
>
