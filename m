Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F6EC433E1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 18:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF864619A4
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 18:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhCVS65 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 14:58:57 -0400
Received: from mx.99rst.org ([52.22.122.190]:41065 "EHLO mx.99rst.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230091AbhCVS6m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 14:58:42 -0400
Received: from mail.kodaksys.org (localhost [127.0.0.1])
        by mx.99rst.org (Postfix) with ESMTP id 3D1C142907;
        Mon, 22 Mar 2021 18:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=99rst.org;
        s=20161001; t=1616439521;
        bh=HzPn0aGwBdg20MxFL9xBowbLt5CvmhrhXqtPmoxZMCU=;
        h=In-Reply-To:References:Date:Subject:From:To:Cc:From;
        b=zmKmp3fOzKs61XLnPoSraq4vn6KnMv9MIBySXEnxaQvvxWLw2IxTjE5W1mcbqa2Le
         Rd2bhB0GXlmvFkStqspfYbiQ6cmEUSCYkUQ5iQZufqh8F7uO6zA6AzTz7e/OtDfen6
         U97xcIzgU5NLkZsMcOkrX6oAx6KKQ0q4NUBii8jJeIpx4EGrXirUzs/P8aNTAe3pV1
         gI5lyjBizGf0pxUpKeBg3D5Itbhklbr7Qxdls9oTMdWiv97QYdPXpnFBT25CJolUZi
         qkp6+SWLveYrwF47uVJ4vyLO36r3MOvuw2TbdotVhyx4uYqw0UJ2R+jn+T4Be6g21G
         KEa3P24UUMSHQ==
Received: by mail.kodaksys.org with HTTP;
        Mon, 22 Mar 2021 18:58:41 -0000
Message-ID: <6f656f62497fb7c9322432b5eb151b86.squirrel@mail.kodaksys.org>
In-Reply-To: <xmqqlfaf6nu9.fsf@gitster.g>
References: <pull.910.v3.git.1616347731514.gitgitgadget@gmail.com>
    <pull.910.v4.git.1616396267010.gitgitgadget@gmail.com>
    <xmqqlfaf6nu9.fsf@gitster.g>
Date:   Mon, 22 Mar 2021 18:58:41 -0000
Subject: Re: [PATCH v4] gitweb: redacted e-mail addresses feature.
From:   "Georgios Kontaxis" <geko1702+commits@99rst.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uIg==?= 
        <avarab@gmail.com>,
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

> "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> [note to other reviewers. input from those who are more familiar
> with gitweb and Perl is very much appreciated on this patch].
>
>> From: Georgios Kontaxis <geko1702+commits@99rst.org>
>>
>> Gitweb extracts content from the Git log and makes it accessible
>> over HTTP. As a result, e-mail addresses found in commits are
>> exposed to web crawlers and they may not respect robots.txt.
>> This may result in unsolicited messages.
>
> "... are exposed to web crawlers, which spammers may use." would be
> sufficient as a problem description.
>
Using robots.txt was suggested earlier in this review so
I want to make sure people don't rely on it instead.

> After giving a problem description, it is customery to describe the
> solution as if you are ordering the codebase to "be like so", so
> instead of this ...
>
>> This is a feature for redacting e-mail addresses
>> from the generated HTML, etc. content.
>
> ... we may say something like
>
>     Introduce an 'email-privacy' feature, which defaults to false,
>     that redacts e-mail addresses that appear as author/committer
>     info and in log messages from the generated HTML content.
>
Will rephrase.

>> This feature does not prevent someone from downloading the
>> unredacted commit log, e.g., by cloning the repository, and
>> extracting information from it.
>> It aims to hinder the low-effort bulk collection of e-mail
>> addresses by web crawlers.
>
> And this is a good thing to add.  Overall, nicely written.
>
>> Signed-off-by: Georgios Kontaxis <geko1702+commits@99rst.org>
>> ---
>>     gitweb: redacted e-mail addresses feature.
>>
>>     Gitweb extracts content from the Git log and makes it accessible
>> over
>>     HTTP. As a result, e-mail addresses found in commits are exposed to
>> web
>>     crawlers and they may not respect robots.txt. This may result in
>>     unsolicited messages. This is a feature for redacting e-mail
>> addresses
>>     from the generated HTML, etc. content.
>>
>>     This feature does not prevent someone from downloading the
>> unredacted
>>     commit log, e.g., by cloning the repository, and extracting
>> information
>>     from it. It aims to hinder the low-effort bulk collection of e-mail
>>     addresses by web crawlers.
>
> You do not need to repeat the above, which is in the log message above.
>
>>     Changes since v1:
>>
>>      * Turned off the feature by default.
>>      * Removed duplicate code.
>>      * Added note about Gitweb consumers receiving redacted logs.
>>
>>     Changes since v2:
>>
>>      * The feature can be set on a per-project basis. ('override' => 1)
>>
>>     Changes since v3:
>>
>>      * Renamed feature to "email-privacy" and improved documentation.
>>      * Removed UI elements for git-format-patch since it won't be
>> redacted.
>>      * Simplified calls to the address redaction logic.
>>      * Mail::Address is now used to reduce false-positive redactions.
>
> Having these under the --- line like this is very helpful.
>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 0959a782eccb..6630c76d92fd 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -21,6 +21,7 @@
>>  use File::Basename qw(basename);
>>  use Time::HiRes qw(gettimeofday tv_interval);
>>  use Digest::MD5 qw(md5_hex);
>> +use Git::LoadCPAN::Mail::Address;
>
> I'll defer to others who are more familiar with gitweb and Perl
> ecosystem if this is warranted, but I have a feeling that importing
> and using Mail::Address->parse() only because we want to see if a
> given "<string>" is an address is a bit overkill and it might be
> sufficient to do something as crude as m/^<[^@>]+@[a-z0-9-.]+>$/i
>
I think Mail::Address->parse() pretty much does the same thing.
It was suggested earlier in the review to use that function,
similar to what git-send-mail does.
I'm assuming because the maintainers of the Mail package are already
invested in the (accurate) parsing of e-mail addresses.

>> +	# Redact e-mail addresses.
>> +
>> +	# To enable system wide have in $GITWEB_CONFIG
>> +	# $feature{'email-privacy'}{'default'} = [1];
>> +	'email-privacy' => {
>> +		'sub' => sub { feature_bool('email-privacy', @_) },
>> +		'override' => 1,
>> +		'default' => [0]},
>>  );
>>
>>  sub gitweb_get_feature {
>> @@ -3449,6 +3459,32 @@ sub parse_date {
>>  	return %date;
>>  }
>>
>> +sub is_mailaddr {
>> +	my @addrs = Mail::Address->parse(shift);
>> +	if (!@addrs || !$addrs[0]->host || !$addrs[0]->user) {
>> +		return 0;
>> +	}
>> +	return 1;
>> +}
>> +
>> +sub hide_mailaddrs_if_private {
>> +	my $line = shift;
>> +	return $line unless gitweb_check_feature('email-privacy');
>> +	while ($line =~ m/(<[^>]+>)/g) {
>> +		my $match = $1;
>> +		if (!is_mailaddr($match)) {
>> +			next;
>> +		}
>> +		my $offset = pos $line;
>> +		my $head = substr $line, 0, $offset - length($match);
>> +		my $redaction = "<redacted>";
>> +		my $tail = substr $line, $offset;
>> +		$line = $head . $redaction . $tail;
>> +		pos $line = length($head) + length($redaction);
>
> Hmmmm, Perl suggestions from others?  It looks quite strange to see
> that s/// operator is not used and replacement is done manually with
> byte position in a Perl script.
>
If there's a more elegant way to do the above we can certain do that instead.

>>  sub parse_tag {
>>  	my $tag_id = shift;
>>  	my %tag;
>> @@ -3465,7 +3501,7 @@ sub parse_tag {
>>  		} elsif ($line =~ m/^tag (.+)$/) {
>>  			$tag{'name'} = $1;
>>  		} elsif ($line =~ m/^tagger (.*) ([0-9]+) (.*)$/) {
>> -			$tag{'author'} = $1;
>> +			$tag{'author'} = hide_mailaddrs_if_private($1);
>>  			$tag{'author_epoch'} = $2;
>>  			$tag{'author_tz'} = $3;
>>  			if ($tag{'author'} =~ m/^([^<]+) <([^>]*)>/) {
>
> This (and the others that follow the same pattern) looks sensible.
>
>> @@ -7489,7 +7526,8 @@ sub git_log_generic {
>>  			         -accesskey => "n", -title => "Alt-n"}, "next");
>>  	}
>>  	my $patch_max = gitweb_get_feature('patches');
>> -	if ($patch_max && !defined $file_name) {
>> +	if ($patch_max && !defined $file_name &&
>> +		!gitweb_check_feature('email-privacy')) {
>>  		if ($patch_max < 0 || @commitlist <= $patch_max) {
>>  			$paging_nav .= " &sdot; " .
>>  				$cgi->a({-href => href(action=>"patches", -replay=>1)},
>> @@ -7550,7 +7588,8 @@ sub git_commit {
>>  			} @$parents ) .
>>  			')';
>>  	}
>> -	if (gitweb_check_feature('patches') && @$parents <= 1) {
>> +	if (gitweb_check_feature('patches') && @$parents <= 1 &&
>> +		!gitweb_check_feature('email-privacy')) {
>>  		$formats_nav .= " | " .
>>  			$cgi->a({-href => href(action=>"patch", -replay=>1)},
>>  				"patch");
>> @@ -7863,7 +7902,8 @@ sub git_commitdiff {
>>  		$formats_nav =
>>  			$cgi->a({-href => href(action=>"commitdiff_plain", -replay=>1)},
>>  			        "raw");
>> -		if ($patch_max && @{$co{'parents'}} <= 1) {
>> +		if ($patch_max && @{$co{'parents'}} <= 1 &&
>> +			!gitweb_check_feature('email-privacy')) {
>>  			$formats_nav .= " | " .
>>  				$cgi->a({-href => href(action=>"patch", -replay=>1)},
>>  					"patch");
>
> I wouldn't have expected to see the above three hunks in the
> "patch" codepath.  Rather, I was hoping that you'd do something
> like this at startup when you find out that the privacy feature
> is enabled:
>
> 	$feature{'patches'}{'default'} = [0]
> 		if gitweb_get_feature('email-privacy');
>
> so that nothing related to the 'patches' has to be modified.
> That way, even if there were fourth place that can leak an e-mail
> address in the 'patch' codepath that above three hunks in this patch
> missed, crawlers won't be able to get at it, no?
>
Or there's multiple feature flags / triggers that lead to the "patch"
codepath.
Either way is fine with me. (disabling the "patches" feature or preventing
the
generation of UI elements)
Like you said, someone who regularly reviews Gitweb code may have an opinion
on how do this.

>> diff --git a/t/lib-gitweb.sh b/t/lib-gitweb.sh
>> index 1f32ca66ea51..77fc1298d4c6 100644
>> --- a/t/lib-gitweb.sh
>> +++ b/t/lib-gitweb.sh
>> @@ -67,6 +67,9 @@ gitweb_run () {
>>  	GITWEB_CONFIG=$(pwd)/gitweb_config.perl
>>  	export GITWEB_CONFIG
>>
>> +	PERL5LIB="$GIT_BUILD_DIR/perl:$GIT_BUILD_DIR/perl/FromCPAN"
>> +	export PERL5LIB
>> +
>
> Why is this change suddenly become necessary?  This addition is only
> about tests---do we need to do something similar in the runtime
> environment when the updated gitweb that requires Mail::Address gets
> deployed, or is that covered already somewhere else?
>
This is necessary because osx-clang, osx-gcc tests were failing.
If there's a better way to address this I'm open to suggestions.

I haven't been able to experience deployment on osx but on linux
i didn't have to change anything.

> Thanks.
>


