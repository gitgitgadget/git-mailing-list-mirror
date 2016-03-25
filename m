From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v10 2/2] pull --rebase: add --[no-]autostash flag
Date: Fri, 25 Mar 2016 04:31:35 -0400
Message-ID: <CAPig+cSdegoGNCMBMcHyEYiE+LUzixvdk-qu0Q-zbFvatX2=KA@mail.gmail.com>
References: <1458584283-23816-1-git-send-email-mehul.jain2029@gmail.com>
	<1458591170-28079-1-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 09:31:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajN9l-0001bA-LK
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 09:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619AbcCYIbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 04:31:39 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34015 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568AbcCYIbg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 04:31:36 -0400
Received: by mail-vk0-f65.google.com with SMTP id e6so7321025vkh.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 01:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=bLBJDHV+KZdhtD2Am+LkfgL0HAC1uZMmFo0P7FQKhlk=;
        b=i5nkK3xy+6T3+TLNXpJsVJgYJu8h7cn/fpYfaG4YGmDk23zF+oTmCYqim1Ruk09HFh
         NpqLLlmDbNDVgnoKDSQ+izjZYAbx/MhTaY4//8hutFV50FsgFsKdVW/XL393x9u0VArC
         OKpCrAEwceUUUV8jpSgxzDFDk5fyqGZg855APdkrb2JNnodoIdsFuCQkBU6Sx9UBPAee
         l+xhcDfjnpJ6yKaCdoRdNvU7tIGFBBjlFSFV6GsK453EsmxZVzSqDvsZvrdXc1AoRBfL
         JhZDZF2NBLigjLbl74ycUUTMfNZi1GpYvIz+Ww8eDBuSwgZV2RpQFhvE0SOLMHrWmG6E
         JcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=bLBJDHV+KZdhtD2Am+LkfgL0HAC1uZMmFo0P7FQKhlk=;
        b=AZXr/gsScXBxIgiBHhada+T7INHwh/L5QuRr4CV4qmdJg/mIIk3E6JGkWN5KKKqT1C
         nn0vaywa497dLs9XfygxDVq+fD3i5o8LWElTgtmVtqxAkQOE+WjPkyGgwQLau33I2MBJ
         i8qD0NJ13CMj22vjgrumUBOUZu+l1JW5vEAioVo8QPS08mtG2AURFMXMNRfkP6RWGc2g
         pb4Bp9vDCNNAIIEOypCetslqrca504BS5HDwgj9uoBEZXxWoXulD8Df3PwHg4qu3h+P3
         FOV3DyvB7aBjH6wQWLFzLb3oZK/AeyJ8mvfcAMrac9qUYKmpDqs5b8aNkO2d0AD5b7TG
         7IVw==
X-Gm-Message-State: AD7BkJLtylR1gVd50heIzAOHpOb+Jlwx+Qssi9I7tHfUUyUKmV4SHGv6fraM7kvSuZL5DPr/Au17iVPzLB8alQ==
X-Received: by 10.31.146.5 with SMTP id u5mr5785972vkd.19.1458894695634; Fri,
 25 Mar 2016 01:31:35 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Fri, 25 Mar 2016 01:31:35 -0700 (PDT)
In-Reply-To: <1458591170-28079-1-git-send-email-mehul.jain2029@gmail.com>
X-Google-Sender-Auth: rNaMskIS6peLv6_i09YlHwKd5PA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289860>

On Mon, Mar 21, 2016 at 4:12 PM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> If rebase.autoStash configuration variable is set, there is no way to
> override it for "git pull --rebase" from the command line.
>
> Teach "git pull --rebase" the --[no-]autostash command line flag which
> overrides the current value of rebase.autoStash, if set. As "git rebase"
> understands the --[no-]autostash option, it's just a matter of passing
> the option to underlying "git rebase" when "git pull --rebase" is called.

This version of the patch (coupled with patch 1/2) is a pleasant
improvement over previous versions due to the cleaner structure, less
noisy diff, and general simplicity (thus easier to reason about and
review).

See below for a nit and some comments about the tests.

> Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
> ---
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> @@ -256,6 +256,76 @@ test_expect_success 'pull --rebase succeeds with dirty working directory and reb
>         test "$(cat file)" = "modified again"
>  '
>
> +test_expect_success 'pull --rebase --autostash & rebase.autostash=true' '

Nit: Some of the test titles spell this as "rebase.autostash" while
others use "rebase.autoStash".

> +       test_config rebase.autostash true &&
> +       git reset --hard before-rebase &&
> +       echo dirty >new_file &&
> +       git add new_file &&
> +       git pull --rebase --autostash . copy &&
> +       test_cmp_rev HEAD^ copy &&
> +       test "$(cat new_file)" = dirty &&
> +       test "$(cat file)" = "modified again"
> +'
> +
> +test_expect_success 'pull --rebase --autostash & rebase.autoStash=false' '
> +       test_config rebase.autostash false &&
> +       git reset --hard before-rebase &&
> +       echo dirty >new_file &&
> +       git add new_file &&
> +       git pull --rebase --autostash . copy &&
> +       test_cmp_rev HEAD^ copy &&
> +       test "$(cat new_file)" = dirty &&
> +       test "$(cat file)" = "modified again"
> +'
> +
> +test_expect_success 'pull --rebase: --autostash & rebase.autoStash unset' '

The title says that this is testing with rebase.autoStash unset,
however, the test itself doesn't take any action to ensure that it is
indeed unset. As with the two above tests which explicitly set
rebase.autoStash, this test should explicitly unset rebase.autoStash
to ensure consistent results even if some future change somehow
pollutes the configuration globally. Therefore:

    test_unconfig rebase.autostash &&

> +       git reset --hard before-rebase &&
> +       echo dirty >new_file &&
> +       git add new_file &&
> +       git pull --rebase --autostash . copy &&
> +       test_cmp_rev HEAD^ copy &&
> +       test "$(cat new_file)" = dirty &&
> +       test "$(cat file)" = "modified again"
> +'

With the addition of these three new tests, aside from the
introductory 'test_{un}config', this exact sequence of commands is now
repeated four times in the script. Such repetition suggests that the
common code should be moved to a function. For instance:

    test_rebase_autostash () {
        git reset --hard before-rebase &&
        echo dirty >new_file &&
        git add new_file &&
        git pull --rebase . copy &&
        test_cmp_rev HEAD^ copy &&
        test "$(cat new_file)" = dirty &&
        test "$(cat file)" = "modified again"
    }

And, a caller would look like this:

    test_expect_success 'pull ... rebase.autostash=true' '
        test_config rebase.autostash true &&
        test_rebase_autostash
    '

Of course, you'd also update the original test, from which this code
was copied, to also call the new function. Factoring out the common
code into a function should probably be done as a separate preparatory
patch.

This suggestion isn't mandatory and doesn't demand a re-roll, but, if
you're feeling ambitious, it would make the code easier to digest and
review.

> +test_expect_success 'pull --rebase --no-autostash & rebase.autostash=true' '
> +       test_config rebase.autostash true &&
> +       git reset --hard before-rebase &&
> +       echo dirty >new_file &&
> +       git add new_file &&
> +       test_must_fail git pull --rebase --no-autostash . copy 2>err &&
> +       test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err

I don't care strongly, but many tests consider test_must_fail() alone
sufficient to verify proper behavior and don't bother being more exact
by checking the precise error message (since error messages sometimes
get refined, thus requiring adjustments to the tests). If you do
retain the error message check, it's often sufficient to check for
just a fragment of the error string rather than the full message. For
instance, it might be fine to grep merely for "uncommitted changes".

> +'
> +
> +test_expect_success 'pull --rebase --no-autostash & rebase.autostash=false' '
> +       test_config rebase.autostash false &&
> +       git reset --hard before-rebase &&
> +       echo dirty >new_file &&
> +       git add new_file &&
> +       test_must_fail git pull --rebase --no-autostash . copy 2>err &&
> +       test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
> +'
> +
> +test_expect_success 'pull --rebase --no-autostash & rebase.autostash unset' '

Same comment as above:

    test_unconfig rebase.autostash &&

> +       git reset --hard before-rebase &&
> +       echo dirty >new_file &&
> +       git add new_file &&
> +       test_must_fail git pull --rebase --no-autostash . copy 2>err &&
> +       test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
> +'

Same comment as above about the common code shared by these three new
test: moving it to a function is suggested.

> +test_expect_success 'pull --autostash (without --rebase) should error out' '
> +       test_must_fail git pull --autostash . copy 2>actual &&
> +       echo "fatal: --[no-]autostash option is only valid with --rebase." >expect &&
> +       test_i18ncmp actual expect

Same comment as above about checking the exact error message (vs. just
trusting test_must_fail).

Also, you mentioned in your cover letter that you couldn't use
test_i18ngrep because grep was mistaking "--[no-]autostash" in the
above expression as a command-line option. If you were using the exact
string as above as an argument to test_i18ngrep, then it is more
likely that the problem was that grep was seeing "[no-]" as a
character class rather than as a literal pattern to match. You could
get around this either by escaping the [ and ] with a backslash (\) or
by passing -F to test_i18ngrep.

Alternately, as mentioned above, just grep for a fragment of the error
message, such as "only valid with --rebase", rather than the full
diagnostic.

> +'
> +
> +test_expect_success 'pull --no-autostash (without --rebase) should error out' '
> +       test_must_fail git pull --no-autostash . copy 2>actual &&
> +       echo "fatal: --[no-]autostash option is only valid with --rebase." >expect &&
> +       test_i18ncmp actual expect
> +'

Same comment as above about code common to these two tests. However,
in this case, it might be easier simply to use a 'for' loop rather
than a function:

    for i in --autostash --no-autostash
    do
        test_expect_success "pull $i (without --rebase) is illegal" "
           test_must_fail git pull $i . copy 2>actual &&
           test_i18ngrep 'only valid with --rebase' actual
        "
    done

Take special note of how use of double (") and single (') quotes
differ in this case from other tests since $i needs to be interpolated
into the test body.
