Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,RDNS_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (unknown [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4F4C433DB
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 03:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1991B619A3
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 03:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCUDhU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 23:37:20 -0400
Received: from mx.99rst.org ([52.22.122.190]:37442 "EHLO mx.99rst.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229805AbhCUDhC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 23:37:02 -0400
X-Greylist: delayed 387 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Mar 2021 23:37:02 EDT
Received: from mail.kodaksys.org (localhost [127.0.0.1])
        by mx.99rst.org (Postfix) with ESMTP id A064F4203D;
        Sun, 21 Mar 2021 03:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=99rst.org;
        s=20161001; t=1616297433;
        bh=kZhZOpOHojE5/Qo4G79UN5njKAM+WW4hBsnQQbEqN9A=;
        h=In-Reply-To:References:Date:Subject:From:To:Cc:From;
        b=FId+1RHlPZzkrNR1z9K6cWsPofVzQNuxcL0eL3Yi7u66mUPZIfG26zVS9AqhCZKaM
         UqWNxlAow/g7WUUwVHadqRnd7pXekCVI9zipw5dZBnkjfNc4P9spUbZSRjyzhPcflh
         dseap7WeQWwyoi4UPGBsja8EIdSUb8/iTYgXtBHQGtz2DiV1hD5LT/R66txfVOcm6c
         c1mEYMGKpyTmqVBajNGzIT5SwmGisHcxe9dhFDwiC2rQE2Q2wKBbY1IA/fnPIhKjfu
         ZZoMLc5GNWxw8lKQoBJeNZvayCxDqAzIDn1ob44T/kJkS8tAb3hGhf1DG7/OZIxwgR
         lW/+CTVtQMYGg==
Received: by mail.kodaksys.org with HTTP;
        Sun, 21 Mar 2021 03:30:33 -0000
Message-ID: <ebd4f3671db8dd8ce195d3384d44e433.squirrel@mail.kodaksys.org>
In-Reply-To: <8735wpz699.fsf@evledraar.gmail.com>
References: <pull.910.git.1616283780358.gitgitgadget@gmail.com>
    <8735wpz699.fsf@evledraar.gmail.com>
Date:   Sun, 21 Mar 2021 03:30:33 -0000
Subject: Re: [PATCH] gitweb: redacted e-mail addresses feature.
From:   "Georgios Kontaxis" <geko1702+commits@99rst.org>
To:     =?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uIg==?= 
        <avarab@gmail.com>
Cc:     "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org
User-Agent: SquirrelMail
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> On Sun, Mar 21 2021, Georgios Kontaxis via GitGitGadget wrote:
>
>> From: Georgios Kontaxis <geko1702+commits@99rst.org>
>>
>> Gitweb extracts content from the Git log and makes it accessible
>> over HTTP. As a result, e-mail addresses found in commits are
>> exposed to web crawlers. This may result in unsolicited messages.
>> This is a feature for redacting e-mail addresses from the generated
>> HTML content.
>>
>> This feature does not prevent someone from downloading the
>> unredacted commit log and extracting information from it.
>> It aims to hinder the low-effort bulk collection of e-mail
>> addresses by web crawlers.
>
> So web crawlers that aren't going to obey robots.txt?
>
> I'm not opposed to this feature, but a glance at gitweb's documentation
> seems to show that we don't discuss how to set robots.txt up for it at
> all.
>
> Perhaps having that in the docs or otherwise in the default setup would
> get us most of the win of this feature?
>
File robots.txt is basically asking nicely and we should work on that.
At the same time crawlers that look for addresses to send SPAM to
will probably ignore it so this change is meant for them.

>> Signed-off-by: Georgios Kontaxis <geko1702+commits@99rst.org>
>> ---
>
> Odd:
>
>>     gitweb: Redacted e-mail addresses feature.
>>
>>     Gitweb extracts content from the Git log and makes it accessible
>> over
>>     HTTP. As a result, e-mail addresses found in commits are exposed to
>> web
>>     crawlers. This may result in unsolicited messages. This is a feature
>> for
>>     redacting e-mail addresses from the generated HTML content.
>>
>>     This feature does not prevent someone from downloading the
>> unredacted
>>     commit log and extracting information from it. It aims to hinder the
>>     low-effort bulk collection of e-mail addresses by web crawlers.
>>
>>     Signed-off-by: Georgios Kontaxis geko1702+commits@99rst.org
>
> To have this duplication of the patch here below "---", some GGG feature
> gone awry?
>
>> Published-As:
>> https://github.com/gitgitgadget/git/releases/tag/pr-910%2Fkontaxis%2Fkontaxis%2Femail_privacy-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git
>> pr-910/kontaxis/kontaxis/email_privacy-v1
>> Pull-Request: https://github.com/gitgitgadget/git/pull/910
>>
>>  Documentation/gitweb.conf.txt | 12 ++++++++++++
>>  gitweb/gitweb.perl            | 36 ++++++++++++++++++++++++++++++++---
>>  2 files changed, 45 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/gitweb.conf.txt
>> b/Documentation/gitweb.conf.txt
>> index 7963a79ba98b..10653d8670a8 100644
>> --- a/Documentation/gitweb.conf.txt
>> +++ b/Documentation/gitweb.conf.txt
>> @@ -896,6 +896,18 @@ same as of the snippet above:
>>  It is an error to specify a ref that does not pass "git
>> check-ref-format"
>>  scrutiny. Duplicated values are filtered.
>>
>> +email_privacy::
>> +    Redact e-mail addresses from the generated HTML, etc. content.
>> +    This hides e-mail addresses found in the commit log from web
>> crawlers.
>> +    Enabled by default.
>> ++
>> +It is highly recommended to keep this feature enabled unless web
>> crawlers
>> +are hindered in some other way. You can disable this feature as shown
>> below:
>> ++
>> +---------------------------------------------------------------------------
>> +$feature{'email_privacy'}{'default'} = [0];
>> +---------------------------------------------------------------------------
>
> I think there's plenty of gitweb users that are going to be relying on
> the current behavior, so doesn't it make more sense for this to be
> opt-in rather than opt-out?
>
My concern is that Gitweb operators may not understand the need
for this feature or maybe won't be aware the feature exists.

Nevertheless, I've changed the feature to be off by default.
Perhaps we can revisit this decision in the future? :)

>>
>>  EXAMPLES
>>  --------
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 0959a782eccb..9d21c2583e18 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -569,6 +569,15 @@ sub evaluate_uri {
>>  		'sub' => \&feature_extra_branch_refs,
>>  		'override' => 0,
>>  		'default' => []},
>> +
>> +    # Redact e-mail addresses.
>> +
>> +    # To disable system wide have in $GITWEB_CONFIG
>> +    # $feature{'email_privacy'}{'default'} = [0];
>> +	'email_privacy' => {
>> +		'sub' => sub { feature_bool('email_privacy', @_) },
>> +		'override' => 0,
>> +		'default' => [1]},
>>  );
>> [...]
>>  sub gitweb_get_feature {
>> @@ -3471,6 +3480,10 @@ sub parse_tag {
>>  			if ($tag{'author'} =~ m/^([^<]+) <([^>]*)>/) {
>>  				$tag{'author_name'}  = $1;
>>  				$tag{'author_email'} = $2;
>> +				if (gitweb_check_feature('email_privacy')) {
>> +					$tag{'author_email'} = "private";
>> +					$tag{'author'} =~ s/<([^>]+)>/<private>/;
>> +				}
>>  			} else {
>>  				$tag{'author_name'} = $tag{'author'};
>>  			}
>> @@ -3519,6 +3532,10 @@ sub parse_commit_text {
>>  			if ($co{'author'} =~ m/^([^<]+) <([^>]*)>/) {
>>  				$co{'author_name'}  = $1;
>>  				$co{'author_email'} = $2;
>> +				if (gitweb_check_feature('email_privacy')) {
>> +					$co{'author_email'} = "private";
>> +					$co{'author'} =~ s/<([^>]+)>/<private>/;
>> +				}
>>  			} else {
>>  				$co{'author_name'} = $co{'author'};
>>  			}
>> @@ -3529,6 +3546,10 @@ sub parse_commit_text {
>>  			if ($co{'committer'} =~ m/^([^<]+) <([^>]*)>/) {
>>  				$co{'committer_name'}  = $1;
>>  				$co{'committer_email'} = $2;
>> +				if (gitweb_check_feature('email_privacy')) {
>> +					$co{'committer_email'} = "private";
>> +					$co{'committer'} =~ s/<([^>]+)>/<private>/;
>> +				}
>>  			} else {
>>  				$co{'committer_name'} = $co{'committer'};
>>  			}
>> @@ -3568,9 +3589,13 @@ sub parse_commit_text {
>>  	if (! defined $co{'title'} || $co{'title'} eq "") {
>>  		$co{'title'} = $co{'title_short'} = '(no commit message)';
>>  	}
>> -	# remove added spaces
>> +	# remove added spaces, redact e-mail addresses if applicable.
>>  	foreach my $line (@commit_lines) {
>>  		$line =~ s/^    //;
>> +		if (gitweb_check_feature('email_privacy') &&
>> +			$line =~ m/^([^<]+) <([^>]*)>/) {
>> +			$line =~ s/<([^>]+)>/<private>/;
>> +		}
>>  	}
>>  	$co{'comment'} = \@commit_lines;
>
> All of these hunks (and the below) should use some new function that
> does this feature check + sanitizing instead of copy/pasting mostly the
> same code N times. e.g.:
>
>     sub maybe_hide_email {
>         my $email = shift;
>         return $email unless gitweb_check_feature('email_privacy');
>         return hide_email($email);
>     }
>
> then:
>
>     $tag{author_email} = maybe_hide_email($2);
>
> Also it looks like this isn't a new issue, but does this need to
> implement its own E-Mail parser? We ship with Mail::Address for
> git-send-email, can gitweb (and the elided hide_email() function above)
> use that too?
>
Thanks for the suggestion.
I've removed the duplicate code.

The places where there are e-mail addresses today are pretty specific.
(Pretty much the author, committer fields and the Signed-off-by lines)

In theory someone could write a comment with a bunch of addresses in it
but that would be unstructured text and I think Mail::Address is not good
with that.

I can definitely keep working on this topic but maybe in subsequent PRs?
Assuming we're not exposing any addresses right now or redacting things
we shouldn't.

>
>> @@ -8060,8 +8085,13 @@ sub git_commitdiff {
>>  		close $fd
>>  			or print "Reading git-diff-tree failed\n";
>>  	} elsif ($format eq 'patch') {
>> -		local $/ = undef;
>> -		print <$fd>;
>> +		while (my $line = <$fd>) {
>> +			if (gitweb_check_feature('email_privacy') &&
>> +				$line =~ m/^([^<]+) <([^>]*)>/) {
>> +				$line =~ s/<([^>]+)>/<private>/;
>> +			}
>> +			print $line;
>> +		}
>>  		close $fd
>>  			or print "Reading git-format-patch failed\n";
>
> Is that "patch" output meant for "git am"? Won't this severely break
> that use-case if so?
>
Not sure who may be consuming that output.
I've added a note in the documentation for gitweb.conf.

If a web crawler can get to the information by following URLs
then I think we should redact it.

Hopefully by documenting this as a potential issue Gitweb operators
can create a workaround specific to their use case.
Possibly implementing access control and leaving this feature off.

