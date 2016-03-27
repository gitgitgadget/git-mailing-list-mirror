From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v10 1/3] parse-options.c: make OPTION__COUNTUP understand
 "unspecified" values
Date: Sat, 26 Mar 2016 22:45:41 -0400
Message-ID: <CAPig+cTB+xZmwALTY2Oy2_dVXknSEjaBiQ8NNr-qOVOZKjHvXw@mail.gmail.com>
References: <01020153a7ba4e07-f326395b-63df-4f8a-b378-8f387b02d0bd-000000@eu-west-1.amazonses.com>
	<01020153b478cf07-758c7f14-33a1-4a67-9bc9-4688de3d6742-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 27 04:45:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ak0i6-0000zs-B0
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 04:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551AbcC0Cpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2016 22:45:43 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36723 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480AbcC0Cpm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2016 22:45:42 -0400
Received: by mail-vk0-f66.google.com with SMTP id z68so11483740vkg.3
        for <git@vger.kernel.org>; Sat, 26 Mar 2016 19:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=5tk3aYiQBpoynNwgIC+sgxtuJ/x/lP1yaWbT92UM4zY=;
        b=RuROljwMJysZv9jLhCiRbLT9Gsu1gPnsOxlL+OW8fTIku54742HOqfasKU05Sa11qF
         fFLM/ir4TBUSFcyGJD84xtlhpECno9lA1hB4fCzht/aarJnXjm/MJUBqADWFbRRCKyl4
         WPKWED4jSvkG88ErDhpW07/BOwMo4ePmqs3GiCeThl+FD/FrXO2KunLCntAQxx+ZX3vA
         7YFDwinkWCLvkYJq1WHBF419JnGxkUiHEOYdaFl/15LhkF7rU7AgCZLJaUDVoF3cCH2X
         RpqIYj2+GfgoWNgWdgjHgmm8gun5tvYjD6bRSJdhD40X4QPCyNhGbsg5Vnebps5CV09g
         NtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=5tk3aYiQBpoynNwgIC+sgxtuJ/x/lP1yaWbT92UM4zY=;
        b=N1nFm0ryCiOahStcBdciVv4omta6HhBDU+SPVRZ8dROY51cgi4DsFV11hI+B4cTFQ9
         69vcit6JwKm/lpKavYCqLrSSGxsXuifSWIr+GTZhOUitdaXlsJhEl+BypCSKD/Re5SmH
         5iVLmyLvQRgYks/IaeGkEHdRMVw4SXnhHAfH9bu5bxLmtStqi6KJSovfa7epc7Wgo2FV
         xpEI/Wp7j6S0lw0FeN9CEPj0o7LIdtMEYDQH6ZWetR2RZ7P4T8ja47IdwNFW22RurlWK
         3B+X0UqgH75MaYLmhkgaeoj2DxYkWDH0NcRGqiMOBB06XJqLcWfQLsJ6Z6sP6WODb/Xs
         q/Qg==
X-Gm-Message-State: AD7BkJKn39TwLK3p2b75igYG6JXnq+TeInBUWkkL6pWSv8X2tODZ6dKmSSakscPqfWjUmzdHBG/kpZHZS7C73Q==
X-Received: by 10.159.36.248 with SMTP id 111mr9488742uar.99.1459046741163;
 Sat, 26 Mar 2016 19:45:41 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Sat, 26 Mar 2016 19:45:41 -0700 (PDT)
In-Reply-To: <01020153b478cf07-758c7f14-33a1-4a67-9bc9-4688de3d6742-000000@eu-west-1.amazonses.com>
X-Google-Sender-Auth: CHbDVkeGwIFevv9_BUW03PDv_AQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289991>

On Sat, Mar 26, 2016 at 3:48 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> parse-options.c: make OPTION__COUNTUP understand "unspecified" values

A bit clearer: s/understand/respect/
Also: s/__/_/

> The reason to make it understand negative values or more specifically
> "unspecified" values is to give the ability to differentiate whether
> `--option` or `--no-option` was specified at all.

The word "negative" shows up far too early in this paragraph, even
before "unspecified". It also fails utterly to explain what
"unspecified" means and how to use it. It does vaguely explain why
respecting "unspecified" is desirable (to know if --[no-]option was
seen), but otherwise leaves the reader quite clueless.

> Many uses of COUNTUP have now been replaced with BOOL and what remains
> are verbose/quiet/force. This change will not affect existing users of
> COUNTUP at all, as long as they use the initial value of 0 (or more), as
> there is no mechanism to decrement. The only thing the command line can
> do is to reset it to zero with "--no-foo".

Copying this paragraph verbatim from Junio's email[1] isn't
necessarily the best way to compose a commit message. Junio was
"thinking out loud" while justifying the change to himself as being
safe, but you ought to reframe this reasoning into a more concise form
which flows with the rest of the commit message, keeping the important
bits and dropping others.

> Verbose or quiet don't use negative values before this commit but force
> uses it in a different way to handle its config and then munges the "-1"
> into 0 before we get to parse_options.

Presumably, you're talking about a very specific instance of -1 in
conjunction with OPT__FORCE in builtin/clean.c, but that information
is entirely missing from this paragraph, thus this explanation serves
only to confuse rather than clarify. It is a good idea to cite this
specific unusual case when justifying that this change is safe, but it
must be accompanied by sufficient context for the reader to understand
what is being said.

> There are uses of COUNTUP in cmd_hash_object() and test-parse-options.c
> and they are both fine.

What does "fine" mean? I know from reading the code that "fine" means
that these clients initialize the values to 0, thus should see no
behavioral difference. But why are these two cases called out
specially when they are already covered by the above "as long as they
use initial value of 0" explanation? As a reader, having these two
cases mentioned specially makes me wonder if I'm missing something
non-obvious about them.

It would probably be better to avoid mentioning cmd_hash_object() and
test-parse-options.c at all, and instead explain generally that, with
one exception (builtin/clean.c), all current clients of OPTION_COUNTUP
use an initial value of zero, thus are not impacted by this change.
And, then go on to explain builtin/clean.c's special case and why it
is safe, as well.


Sorry for seeming to be very picky, but if I hadn't already been
following this topic (and hadn't in fact suggested this particular
change), as a reader, I think I would find this commit message utterly
baffling, and wouldn't have a clue what this change is about or why it
is desirable.

Perhaps it would be a good idea to re-read "(2) Describe your changes
well" in Documentation/SubmittingPatches for hints about writing a
good commit message, as well as Junio's recent re-stating[2] of those
hints.

Try to write the commit message as if you were speaking to someone who
wasn't already familiar with the issue you're trying to solve.
Specifically, explain the problem ("no way to distinguish between
--[no-]option being seen or not"); explain the solution ("introduce an
'unspecified' value"); the implementation of the "unspecified" value
("any negative number" plus an example of how to make use of it);
justify that the change is safe ("existing clients of OPTION_COUNTUP
are not impacted because ...").

> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> The discussion about this patch:
> [1] : http://thread.gmane.org/gmane.comp.version-control.git/289027
>
> Previous version of the patch:
> [v1] : http://thread.gmane.org/gmane.comp.version-control.git/289061

Unless I'm mistaken, the previous version was v9[3], not v1.

> Changes introduced:
> Use a different language in commit message to make the change and its
> utility more clear. Also added some points as to where this patch could
> break but it doesn't.

This version forgets to add the new tests to t0040-parse-options.sh
which SZEDER requested[4] to ensure that the new behavior works as
expected.

> ---
> diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
> @@ -144,8 +144,12 @@ There are some macros to easily define options:
>
>  `OPT_COUNTUP(short, long, &int_var, description)`::
>         Introduce a count-up option.
> -       `int_var` is incremented on each use of `--option`, and
> -       reset to zero with `--no-option`.
> +       Each use of `--option` increments `int_var`, starting from zero
> +       (even if initially negative), and `--no-option` resets it to
> +       zero. To determine if `--option` or `--no-option` was set at
> +       all, set `int_var` to a negative value, and if it is still

I realize that you copied this text verbatim from the example I
gave[5], but in retrospect, I think s/set/initialize/ would be a bit
more clear:

    all, initialize `int_var` to a negative value, ...

> +       negative after parse_options(), then neither `--option` nor
> +       `--no-option` was seen.

[1]: http://article.gmane.org/gmane.comp.version-control.git/289264/
[2]: http://article.gmane.org/gmane.comp.version-control.git/289757/
[3]: http://thread.gmane.org/gmane.comp.version-control.git/288820/focus=289724
[4]: http://article.gmane.org/gmane.comp.version-control.git/289733
[5]: http://article.gmane.org/gmane.comp.version-control.git/289822
