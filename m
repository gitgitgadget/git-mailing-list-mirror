Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DBEC2BA1A
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 06:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D907206BF
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 06:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgDZGgJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Apr 2020 02:36:09 -0400
Received: from 14.mo4.mail-out.ovh.net ([46.105.40.29]:37677 "EHLO
        14.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgDZGgI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Apr 2020 02:36:08 -0400
X-Greylist: delayed 1085 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Apr 2020 02:36:06 EDT
Received: from player763.ha.ovh.net (unknown [10.108.35.13])
        by mo4.mail-out.ovh.net (Postfix) with ESMTP id 450F32331AC
        for <git@vger.kernel.org>; Sun, 26 Apr 2020 08:18:00 +0200 (CEST)
Received: from RCM-web10.webmail.mail.ovh.net (ip-209.net-89-3-147.rev.numericable.fr [89.3.147.209])
        (Authenticated sender: postmaster@rapsys.eu)
        by player763.ha.ovh.net (Postfix) with ESMTPSA id E6E3911BFB3CA;
        Sun, 26 Apr 2020 06:17:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sun, 26 Apr 2020 08:17:55 +0200
From:   =?UTF-8?Q?Rapha=C3=ABl_Gertz?= <git@rapsys.eu>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?UTF-8?Q?Rapha=C3=ABl_Gertz_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar?= =?UTF-8?Q?=C4=99bski?= <jnareb@gmail.com>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] commit:fix use of uninitialized value [...] in server log
In-Reply-To: <20200426001740.GB877@gmail.com>
References: <pull.767.git.git.1587847338677.gitgitgadget@gmail.com>
 <20200426001740.GB877@gmail.com>
User-Agent: Roundcube Webmail/1.4.2
Message-ID: <b64c0b21fedd0033c237ad4c0b18c18b@rapsys.eu>
X-Sender: git@rapsys.eu
X-Originating-IP: 89.3.147.209
X-Webmail-UserID: postmaster@rapsys.eu
X-Ovh-Tracer-Id: 2853030364885388906
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrheeigdduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggtgfgfffhvffujghffgfkgihisehtkehjtddtreejnecuhfhrohhmpeftrghphhgrtohlpgfivghrthiiuceoghhithesrhgrphhshihsrdgvuheqnecukfhppedtrddtrddtrddtpdekledrfedrudegjedrvddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejieefrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhithesrhgrphhshihsrdgvuhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Le 26.04.2020 02:17, Jonathan Nieder a écrit :
> (cc-ing Jakub Narębski, gitweb expert; Giuseppe Bilotta, who 
> contributed
>  snapshot_format)
> Raphaël Gertz wrote:
>> Subject: commit:fix use of uninitialized value [...] in server log
>> 
>> This change fix the message about uninitialized value when trying to
>> access undefined hash indexes.
>> 
>> The error message fixed:
>> Use of uninitialized value $params{"action"} in string eq at 
>> gitweb.cgi
>> line 1377
> 
> Some nitpicks about the commit message (see
> Documentation/SubmittingPatches "Describe your changes well" for more 
> on
> this subject):
> 
> - the subject line should start with the subsystem being improved, a
>   colon, and a space.  Here, that subsystem is gitweb.
> 
> - focus on describing what improvement the patch intends to make.  The
>   description should be in the imperative mood, as though ordering the
>   codebase to improve.
> 
> - try to cover what a person trying to understand whether to apply
>   this patch would want to know beyond what is already in the patch
>   itself.  What user-facing behavior change does the patch make?  How
>   was the problem discovered?  What downsides are there, if any?
> 
> I think that would mean something like
> 
> 	gitweb: check whether query params are defined before use
> 
> 	In normal use, gitweb spams the web server error log:
> 
> 	  Use of uninitialized value $params{"action"} in string eq at
> gitweb.cgi line 1377
> 
> 	The 'action' parameter is optional so this is not warning about
> 	anything meaningful. Check whether the parameter is defined
> 	before using it to avoid the warning.
> 
> 	Signed-off-by: ...
> 
Thank's for explaining how to improve the bug report.

> Please don't.  A contributor list can be obtained using "git shortlog
> -n -s -- gitweb".  A second changelog would fall out of sync with
> that.
> 
Didn't know sorry.

>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -1420,7 +1420,7 @@ sub href {
>> 
>>  		# since we destructively absorb parameters, we keep this
>>  		# boolean that remembers if we're handling a snapshot
>> -		my $is_snapshot = $params{'action'} eq 'snapshot';
>> +		my $is_snapshot = defined $params{'action'} && $params{'action'} eq 
>> 'snapshot';
> 
> nit: long line
> 
> Other parameters like 'project' similarly use a defined check like
> this, so it's consistent.  Good.
> 
>> 
>>  		# Summary just uses the project path URL, any other action is
>>  		# added to the URL
>> 		if (defined $params{'action'}) {
> 
> optional: should we reuse this "if"?  That is, something like
> 
> 		my $is_snapshot = 0;
> 
> 		if (defined $params{'action'}) {
> 			$is_snapshot = $params{'action'} eq 'snapshot';
> 			$href .= ...
> 
It may involve less risk to keep the variabe undefined:
		my $is_snapshot = undef;
instead of:
		my $is_snapshot = 0;

As I don't have time to maintain the changes and am not a perl Jedi,
I may have wanted to avoid rewriting lot of code.

I only intended to make minimalist code modification to avoid breaking
without noticing something and get cursed for it :)

>> @@ -6012,7 +6012,7 @@ sub git_history_body {
>>  		      $cgi->a({-href => href(action=>$ftype, hash_base=>$commit, 
>> file_name=>$file_name)}, $ftype) . " | " .
>>  		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, 
>> "commitdiff");
>> 
>> -		if ($ftype eq 'blob') {
>> +		if (defined $ftype && $ftype eq 'blob') {
> 
> What is this part about?  The commit message doesn't describe it.
> 
>>  			print " | " .
>>  			      $cgi->a({-href => href(action=>"blob_plain", 
>> hash_base=>$commit, file_name=>$file_name)}, "raw");
>> 
>> 
This is an other test on possibly undefined value.

THis fix intent to remove an other warning in server log when ftype is 
not defined.

Error log will look like :
gitweb.cgi: Use of uninitialized value $ftype in string eq at 
/path/gitweb.cgi line 5962.: /path/gitweb.cgi

I just went to notice I missed an other error message spammed as well :
gitweb.cgi: Use of uninitialized value $commit_id in open at 
/path/gitweb.cgi line 3568.: /path/gitweb.cgi

I will try to add the patch for this when possible as well.

Best regards
