From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFCv3 1/2] gitweb: add patch view
Date: Sat, 6 Dec 2008 13:34:57 +0100
Message-ID: <cb7bb73a0812060434r2b48fd1ev359020fb1e0d1603@mail.gmail.com>
References: <1228345188-15125-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1228345188-15125-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <200812060134.22959.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 13:36:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8wOa-0007fQ-8y
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 13:36:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755638AbYLFMfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 07:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755180AbYLFMfE
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 07:35:04 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:63504 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbYLFMfA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 07:35:00 -0500
Received: by ey-out-2122.google.com with SMTP id 6so166734eyi.37
        for <git@vger.kernel.org>; Sat, 06 Dec 2008 04:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=KJgWNlCmKR1V+JCZ8gwtiSLen3UkyoaMPuS4RIOXHwo=;
        b=TSf+U/RNgmo8UMagK7plgN4y1yeVhRpJvSXLX9mLC/J1bD942pM6dzk3TFvv7et0rV
         J07AqYGkHhLnhE/Z82k8JFOJcDmcIQZG6EpEFZL3khou1Z/DR3FAR5dIhP9wKglbnWTv
         rntZEuLE+wSBYDHam9Fqpt+SnwhWQgaurtzYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=MHHakEIs4PaxBW4wvhYqjHlC1rUzyuELlJrxEzvIhV2dfLrJpCYoPT6X6jjjg2l1zU
         D+wl7G9PIVypfFlrNB6zFHY5ryuN2GBdowYUMsZHbXb4z88sHh5yvsKQA5raIylO4734
         QB0V9GVoDZ00plYtp77VViMz994L74WCivT2c=
Received: by 10.210.125.13 with SMTP id x13mr1157461ebc.198.1228566897491;
        Sat, 06 Dec 2008 04:34:57 -0800 (PST)
Received: by 10.210.79.12 with HTTP; Sat, 6 Dec 2008 04:34:57 -0800 (PST)
In-Reply-To: <200812060134.22959.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102449>

On Sat, Dec 6, 2008 at 1:34 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Wed, 3 Dec 2008, Giuseppe Bilotta wrote:
>
>> The manually-built email format in commitdiff_plain output is not
>> appropriate for feeding git-am, because of two limitations:
>>  * when a range of commits is specified, commitdiff_plain publishes a
>>    single patch with the message from the first commit, instead of a
>>    patchset,
>
> This is because 'commitdiff_plain' wasn't _meant_ as patch series view,
> to be fed to git-am. Actually it is a bit cross between "git show"
> result with '--pretty=email' format, and "git diff" between two commits,
> to be fed to git-apply or GNU patch.
>
> Nevertheless the above reasoning doesn't need to be put in a commit
> message. But it explains why new 'patch' / 'patchset' view is needed:
> because there was no equivalent.

I'll remove it.

>>  * in either case, the patch summary is replicated both as email subject
>>    and as first line of the email itself, resulting in a doubled summary
>>    if the output is fed to git-am.
>
> This is independent issue which is I think worth correcting anyway,
> unless we decide to scrap 'commitdiff_plain' view altogether.
> But I think we would want some text/plain patch view to be applied
> by GNU patch (for example in RPM .spec file).

I don't think we should scrap commitdiff either, but the subject
replication is not really an issue if the view is not fed to git am.

>> +     # The maximum number of patches in a patchset generated in patch
>> +     # view. Set this to 0 or undef to disable patch view, or to a
>> +     # negative number to remove any limit.
>> +     'patches' => {
>> +             'override' => 1,
>> +             'default' => [16]},
>>  );
>
> You need to set "'sub' => \&feature_patches" for feature to be
> override-able at all.  Also features are usually not overridable
> by default, which reduces load a tiny bit (by _possibly_ not reading
> config, although that shouldn't matter much now with reading whole
> commit using single call to git-config, and not one call per variable).

I think I'll make the feature non-overridable. I'll also make it
default to disabled, although I'm not particularly happy with the
choice.

> And I think the default might be set larger: 'log' view generates
> as big if not bigger load, and it is split into 100 commits long
> pages.

Hm, I would say the load of patch view is much higher than the load of
log view, both in terms of bandwidth and in terms of load on the
server, because of the diffs.

>>  sub git_commitdiff {
>>       my $format = shift || 'html';
>> +
>> +     my $patch_max = gitweb_check_feature('patches');
>
> Wouldn't it be better to name this variable $max_patchset_size, or
> something like that? I'm not saying that this name is bad, but I'm
> wondering if it could be better...

max_patchset_size sounds much worse than patch_max to me, which is why
I went for the latter 8-)

>>       if ($format eq 'html') {
>>               $formats_nav =
>>                       $cgi->a({-href => href(action=>"commitdiff_plain", -replay=>1)},
>> @@ -5483,7 +5498,12 @@ sub git_commitdiff {
>>               open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
>>                       '-p', $hash_parent_param, $hash, "--"
>>                       or die_error(500, "Open git-diff-tree failed");
>> -
>> +     } elsif ($format eq 'patch') {
>> +             open $fd, "-|", git_cmd(), "format-patch", '--encoding=utf8',
>> +                     '--stdout', $patch_max > 0 ? "-$patch_max" : (),
>
>> +                     $hash_parent ? ('-n', "$hash_parent..$hash") :
>> +                     ('--root', '-1', $hash)
>
> This bit makes 'patch' view behave bit differently than git-format-patch,
> which I think is a good idea: namely it shows single patch if there is
> no cutoff.  This should be mentioned in commit message, and perhaps
> even in a comment in code.
>
> Beside, if you show only single patch because $hash_parent is not set,
> you don't need to examine $patch_max nor set limit, because you use '-1'.
> Currently if $patch_max > 0 and !$hash_parent, you pass limit for the
> number of patches twice.  This I think is harmless but...

I've reworked the code a bit, making the commit spec an array computed
before passing it to the command line. The code is cleaner but
obviously longer 8-)

The double limit worked properly, btw.

>> +             # TODO add X-Git-Tag/X-Git-Url headers in a sensible way
>
> Sensible way would mean modifying git-format-patch to be able to add
> extra headers via command option, just like it is now possible via
> config variable format.headers, I think.  Because there are no surefire
> markers of where one patch ends and another begins: commit message is
> free text, and can contain diff... although if it contains diff
> separator '---' then git-am would have problem with patch; or at least
> even assuming sane commit messages it is not easy.
>
> Also I think that only X-Git-Url makes sense, and it is per whole
> patchset (whole 'patch' view output) and not for each individual
> patch.

I've stripped this commet for the time being. I'm not sure even
X-Git-Url makes sense, and the fact that it should only attached to
the first email makes it an oddball.

-- 
Giuseppe "Oblomov" Bilotta
