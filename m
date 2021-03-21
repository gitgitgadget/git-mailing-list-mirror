Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C78C433DB
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 19:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B60261943
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 19:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhCUTtS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 15:49:18 -0400
Received: from mx.99rst.org ([52.22.122.190]:38921 "EHLO mx.99rst.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230250AbhCUTsg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 15:48:36 -0400
Received: from mail.kodaksys.org (localhost [127.0.0.1])
        by mx.99rst.org (Postfix) with ESMTP id 16FE54231E;
        Sun, 21 Mar 2021 19:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=99rst.org;
        s=20161001; t=1616356116;
        bh=YI2YGqGCgnBTNW2E8XrMEqlgbzdXEQBr4eAk9P2XnJU=;
        h=In-Reply-To:References:Date:Subject:From:To:Cc:From;
        b=oXoF9xYYUKdfe1xhd+r3Aaw8r1hGojaWUz9XxmKCFtrWVp/4Ab9bFx/JJW0HCqXkb
         zhiNIEWHi8l2pS0SNWpC7SXASPkOG3uoaPfciPs70nnTziz446EvP5uIP98iZubJvB
         WNThmmurtdN8BNdDP4OZ4Q8tYlYxogD1UMCAt8S16XEkFT2XQkJ9GyKaU5yzZdu9H5
         UUlU8DZtLzd+h/5Gt0exo7/MCRIMh41AP6hwPk/KHH6biu3/t9/Ap0ccfOpWlPhMOp
         xkEQv/HNJrXOKc9/3S7U/gSSOVprc14/n/zCvCOltFGY0yX4lo/a3p+eXptZbzTtD8
         QIAZQGdImMXlg==
Received: by mail.kodaksys.org with HTTP;
        Sun, 21 Mar 2021 19:48:36 -0000
Message-ID: <35ffea669f679fe3605f3f14fc50c945.squirrel@mail.kodaksys.org>
In-Reply-To: <87r1k8qs73.fsf@evledraar.gmail.com>
References: <pull.910.v2.git.1616297564158.gitgitgadget@gmail.com>
    <pull.910.v3.git.1616347731514.gitgitgadget@gmail.com>
    <87r1k8qs73.fsf@evledraar.gmail.com>
Date:   Sun, 21 Mar 2021 19:48:36 -0000
Subject: Re: [PATCH v3] gitweb: redacted e-mail addresses feature.
From:   "Georgios Kontaxis" <geko1702+commits@99rst.org>
To:     =?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uIg==?= 
        <avarab@gmail.com>
Cc:     "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
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
>> exposed to web crawlers and they may not respect robots.txt.
>> This may result in unsolicited messages.
>> This is a feature for redacting e-mail addresses
>> from the generated HTML, etc. content.
>>
>> This feature does not prevent someone from downloading the
>> unredacted commit log, e.g., by cloning the repository, and
>> extracting information from it.
>> It aims to hinder the low-effort bulk collection of e-mail
>> addresses by web crawlers.
>>
>> Changes since v1:
>> - Turned off the feature by default.
>> - Removed duplicate code.
>> - Added note about Gitweb consumers receiving redacted logs.
>>
>> Changes since v2:
>> - The feature can be set on a per-project basis. ('override' => 1)
>>
>> Signed-off-by: Georgios Kontaxis <geko1702+commits@99rst.org>
>> ---
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
>>
>> Published-As:
>> https://github.com/gitgitgadget/git/releases/tag/pr-910%2Fkontaxis%2Fkontaxis%2Femail_privacy-v3
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git
>> pr-910/kontaxis/kontaxis/email_privacy-v3
>> Pull-Request: https://github.com/gitgitgadget/git/pull/910
>>
>> Range-diff vs v2:
>>
>>  1:  74af11ca8bf2 ! 1:  930cdefe7ee0 gitweb: redacted e-mail addresses
>> feature.
>>      @@ Commit message
>>           - Removed duplicate code.
>>           - Added note about Gitweb consumers receiving redacted logs.
>>
>>      +    Changes since v2:
>>      +    - The feature can be set on a per-project basis. ('override'
>> => 1)
>>      +
>>           Signed-off-by: Georgios Kontaxis <geko1702+commits@99rst.org>
>>
>>        ## Documentation/gitweb.conf.txt ##
>>      @@ gitweb/gitweb.perl: sub evaluate_uri {
>>       +	# $feature{'email_privacy'}{'default'} = [1];
>>       +	'email_privacy' => {
>>       +		'sub' => sub { feature_bool('email_privacy', @_) },
>>      -+		'override' => 0,
>>      ++		'override' => 1,
>>       +		'default' => [0]},
>>        );
>>
>>
>>
>>  Documentation/gitweb.conf.txt | 16 +++++++++++++
>>  gitweb/gitweb.perl            | 42 ++++++++++++++++++++++++++++++++---
>>  2 files changed, 55 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/gitweb.conf.txt
>> b/Documentation/gitweb.conf.txt
>> index 7963a79ba98b..b7af3240177d 100644
>> --- a/Documentation/gitweb.conf.txt
>> +++ b/Documentation/gitweb.conf.txt
>> @@ -896,6 +896,22 @@ same as of the snippet above:
>>  It is an error to specify a ref that does not pass "git
>> check-ref-format"
>>  scrutiny. Duplicated values are filtered.
>>
>> +email_privacy::
>> +    Redact e-mail addresses from the generated HTML, etc. content.
>> +    This hides e-mail addresses found in the commit log from web
>> crawlers.
>> +    Disabled by default.
>> ++
>> +It is highly recommended to enable this feature unless web crawlers are
>> +hindered in some other way. Note that crawlers intent on harvesting
>> e-mail
>> +addresses may disregard robots.txt. You can enable this feature like
>> so:
>> ++
>> +---------------------------------------------------------------------------
>> +$feature{'email_privacy'}{'default'} = [1];
>> +---------------------------------------------------------------------------
>> ++
>> +Note that if Gitweb is not the final step in a workflow then subsequent
>> +steps may misbehave because of the redacted information they receive.
>> +
>>
>>  EXAMPLES
>>  --------
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 0959a782eccb..174cc566d97d 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -569,6 +569,15 @@ sub evaluate_uri {
>>  		'sub' => \&feature_extra_branch_refs,
>>  		'override' => 0,
>>  		'default' => []},
>> +
>> +	# Redact e-mail addresses.
>> +
>> +	# To enable system wide have in $GITWEB_CONFIG
>> +	# $feature{'email_privacy'}{'default'} = [1];
>> +	'email_privacy' => {
>> +		'sub' => sub { feature_bool('email_privacy', @_) },
>> +		'override' => 1,
>> +		'default' => [0]},
>>  );
>>
>>  sub gitweb_get_feature {
>> @@ -3449,6 +3458,19 @@ sub parse_date {
>>  	return %date;
>>  }
>>
>> [snip]
>
> So in the v1 feedback I suggested:
>
> BEGIN QUOTE
>     sub maybe_hide_email {
>         my $email = shift;
>         return $email unless gitweb_check_feature('email_privacy');
>         return hide_email($email);
>     }
>
> then:
>
>     $tag{author_email} = maybe_hide_email($2);
> END QUOTE
>
> But:
>
>>  sub parse_tag {
>>  	my $tag_id = shift;
>>  	my %tag;
>> @@ -3471,6 +3493,10 @@ sub parse_tag {
>>  			if ($tag{'author'} =~ m/^([^<]+) <([^>]*)>/) {
>>  				$tag{'author_name'}  = $1;
>>  				$tag{'author_email'} = $2;
>> +				if (gitweb_check_feature('email_privacy')) {
>> +					$tag{'author_email'} = "private";
>> +					$tag{'author'} = hide_mailaddr($tag{'author'});
>> +				}
>
> This code seems quite awkward, we've already done the regex match, but
> this code:
>
>> [snip]
>> +sub hide_mailaddr_if_private {
>> +	my $line = shift;
>> +	return $line unless (gitweb_check_feature('email_privacy') &&
>> +						$line =~ m/^([^<]+) <([^>]*)>/);
>> +	return hide_mailaddr($line)
>> +}
>> +
>> +sub hide_mailaddr {
>> +	my $mailaddr = shift;
>> +	$mailaddr =~ s/<([^>]*)>/<private>/;
>> +	return $mailaddr;
>> +}
>
> Is going to do it again incrementally, and then just act on a
> search-replacement if we've got the feature enabled.
>
I think hide_mailaddr_if_private (which checks the feature flag
and looks for the pattern) is only called when we haven't done so
already. In every other case we call hide_mailaddr directly.
So there's no duplication of checks.

> It seems much simpler to just turn your:
>
>> +				if (gitweb_check_feature('email_privacy')) {
>> +					$tag{'author_email'} = "private";
>> +					$tag{'author'} = hide_mailaddr($tag{'author'});
>> +				}
>
> Into:
>
>     $tag{'author'} = maybe_hide_mailaddr($tag{author},
> \$tag{author_email});
>
> Using:
>
>     sub maybe_hide_email {
>         my ($email, $ref) = shift;
>         return $email unless gitweb_check_feature('email_privacy');
>         $$ref = "private" if $ref;
>         return hide_email($email);
>     }
>
> Which also works for the case where you don't have a "private" hash key
> to assign to. But maybe it overcomplicates things...
>
>>  			} else {
>>  				$tag{'author_name'} = $tag{'author'};
>>  			}
>> @@ -3519,6 +3545,10 @@ sub parse_commit_text {
>>  			if ($co{'author'} =~ m/^([^<]+) <([^>]*)>/) {
>>  				$co{'author_name'}  = $1;
>>  				$co{'author_email'} = $2;
>> +				if (gitweb_check_feature('email_privacy')) {
>> +					$co{'author_email'} = "private";
>> +					$co{'author'} = hide_mailaddr($co{'author'});
>> +				}
>>  			} else {
>>  				$co{'author_name'} = $co{'author'};
>>  			}
>> @@ -3529,6 +3559,10 @@ sub parse_commit_text {
>>  			if ($co{'committer'} =~ m/^([^<]+) <([^>]*)>/) {
>>  				$co{'committer_name'}  = $1;
>>  				$co{'committer_email'} = $2;
>> +				if (gitweb_check_feature('email_privacy')) {
>> +					$co{'committer_email'} = "private";
>> +					$co{'committer'} = hide_mailaddr($co{'committer'});
>> +				}
>> [...]
>>  			} else {
>>  				$co{'committer_name'} = $co{'committer'};
>>  			}
>> @@ -3568,9 +3602,10 @@ sub parse_commit_text {
>>  	if (! defined $co{'title'} || $co{'title'} eq "") {
>>  		$co{'title'} = $co{'title_short'} = '(no commit message)';
>>  	}
>> -	# remove added spaces
>> +	# remove added spaces, redact e-mail addresses if applicable.
>>  	foreach my $line (@commit_lines) {
>>  		$line =~ s/^    //;
>> +		$line = hide_mailaddr_if_private($line);
>>  	}
>>  	$co{'comment'} = \@commit_lines;
>>
>> @@ -8060,8 +8095,9 @@ sub git_commitdiff {
>>  		close $fd
>>  			or print "Reading git-diff-tree failed\n";
>>  	} elsif ($format eq 'patch') {
>> -		local $/ = undef;
>> -		print <$fd>;
>> +		while (my $line = <$fd>) {
>> +			print hide_mailaddr_if_private($line);
>> +		}
>
> Urm, have you tested this? How does a while loop over a <$fd> make sense
> when $/ is undef, the readline() operator will always return just one
> record, so having a while loop doesn't make sense.
>
$/ is not undef, the opposite, it's the default value which results
in reading from <$fd> one line at a time. (where line is a sequence
terminated by CRLF or LF)

> I'm not sure of the input here, but given that if you're expecting to
> replace all e-mail addresses on all lines with this function that's not
> how it'll work, the s/// doesn't have a /g, so it'll stop at the first
> replacement.
>
So we are reading from <$fd> one line at a time and looking for the
first "expr1 <expr2>" occurrence in each line. This successfully redacts
the author, committer, signed-off-by lines.

Not doing a global replacement per line is intentional so as to avoid
false positives.
So far I haven't noticed missing any addresses that should have been
redacted.

>>  		close $fd
>>  			or print "Reading git-format-patch failed\n";
>>  	}
>>
>> base-commit: a5828ae6b52137b913b978e16cd2334482eb4c1f
>
>


