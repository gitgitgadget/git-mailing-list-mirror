From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFCv3 1/2] gitweb: add patch view
Date: Sat, 6 Dec 2008 14:09:01 +0100
Message-ID: <200812061409.02730.jnareb@gmail.com>
References: <1228345188-15125-1-git-send-email-giuseppe.bilotta@gmail.com> <200812060134.22959.jnareb@gmail.com> <cb7bb73a0812060434r2b48fd1ev359020fb1e0d1603@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 14:10:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8wvd-0008Sz-UO
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 14:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755522AbYLFNJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 08:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754853AbYLFNJJ
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 08:09:09 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:19585 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbYLFNJH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 08:09:07 -0500
Received: by ey-out-2122.google.com with SMTP id 6so169681eyi.37
        for <git@vger.kernel.org>; Sat, 06 Dec 2008 05:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=AZVVlT5unpDtZVUogmP1TFFjhhjzvzR/GFIAQLAotm8=;
        b=Dz5aeb2804m4Oy5F2zAfqi/WkVK+9rtkPO0Y7bXYys6Gtv2SU6kX1YwZGxBTbXO8hO
         rRkW54tsAknF1wy8OcbCC6i8eaetrfreM2Ec/YDfLFY15/9ASgs2IqzHvIBW4nM5ylYt
         /zONruWWXKMV/SUhJVTmzKTKke9ovWVWDhhZc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=h++mtIbHa/hOKQSfExatcVEpcmfu94lFhl/Ms1kR9Q+QDWxR/E3p30Hdx29NWwyHMa
         10kGt1iFv8LYpMXAz4/RuvHraBHKyqfvBrP3dAGJPXpKOmWr2Z79y+WEoc+sABrE9EMo
         EcyDmOawbr2tygx2dsElr7oPHJjJzDYGL7M7o=
Received: by 10.210.67.4 with SMTP id p4mr1223451eba.60.1228568945723;
        Sat, 06 Dec 2008 05:09:05 -0800 (PST)
Received: from ?192.168.1.11? (abvc175.neoplus.adsl.tpnet.pl [83.8.200.175])
        by mx.google.com with ESMTPS id 2sm1546324nfv.38.2008.12.06.05.09.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Dec 2008 05:09:05 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0812060434r2b48fd1ev359020fb1e0d1603@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102453>

On Sat, Dec 6, 2008 at 13:34, Giuseppe Bilotta wrote:
> On Sat, Dec 6, 2008 at 1:34 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Wed, 3 Dec 2008, Giuseppe Bilotta wrote:
>>
>>> The manually-built email format in commitdiff_plain output is not
>>> appropriate for feeding git-am, because of two limitations:
>>>  * when a range of commits is specified, commitdiff_plain publishes a
>>>    single patch with the message from the first commit, instead of a
>>>    patchset,
>>
>> This is because 'commitdiff_plain' wasn't _meant_ as patch series view,
>> to be fed to git-am. Actually it is a bit cross between "git show"
>> result with '--pretty=email' format, and "git diff" between two commits,
>> to be fed to git-apply or GNU patch.
>>
>> Nevertheless the above reasoning doesn't need to be put in a commit
>> message. But it explains why new 'patch' / 'patchset' view is needed:
>> because there was no equivalent.
> 
> I'll remove it.

Errr... sorry, I haven't made myself clear. I meant here that *my*
comment should not be added; your explanation about adding 'patch'
view should IMHO stay, perhaps reworked a bit: commitdiff is not
about generating patch series.

>>>  * in either case, the patch summary is replicated both as email subject
>>>    and as first line of the email itself, resulting in a doubled summary
>>>    if the output is fed to git-am.
>>
>> This is independent issue which is I think worth correcting anyway,
>> unless we decide to scrap 'commitdiff_plain' view altogether.
>> But I think we would want some text/plain patch view to be applied
>> by GNU patch (for example in RPM .spec file).
> 
> I don't think we should scrap commitdiff either, but the subject
> replication is not really an issue if the view is not fed to git am.

Well, there is it.
 
>>> +     # The maximum number of patches in a patchset generated in patch
>>> +     # view. Set this to 0 or undef to disable patch view, or to a
>>> +     # negative number to remove any limit.
>>> +     'patches' => {
>>> +             'override' => 1,
>>> +             'default' => [16]},
>>>  );
>>
>> You need to set "'sub' => \&feature_patches" for feature to be
>> override-able at all.  Also features are usually not overridable
>> by default, which reduces load a tiny bit (by _possibly_ not reading
>> config, although that shouldn't matter much now with reading whole
>> commit using single call to git-config, and not one call per variable).
> 
> I think I'll make the feature non-overridable. I'll also make it
> default to disabled, although I'm not particularly happy with the
> choice.

I think that having 'patches' feature to be able to override is a good
idea, as limit on number of patches might depend on _repository_, for
example being lower for repository with large commits (large in sense
of diff size).

Default with override unset seems to be precedence... as to having it
disabled by default: having feature which require configuration enabled
by default serves as an example of configuration; on the other hand the
example might be in comments, like for 'actions' %feature.
 
>> And I think the default might be set larger: 'log' view generates
>> as big if not bigger load, and it is split into 100 commits long
>> pages.
> 
> Hm, I would say the load of patch view is much higher than the load of
> log view, both in terms of bandwidth and in terms of load on the
> server, because of the diffs.

Ah, I forgot about that. Limit to 16-25 seems to be reasonable, then.
 
>>> @@ -5483,7 +5498,12 @@ sub git_commitdiff {
>>>               open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
>>>                       '-p', $hash_parent_param, $hash, "--"
>>>                       or die_error(500, "Open git-diff-tree failed");
>>> -
>>> +     } elsif ($format eq 'patch') {
>>> +             open $fd, "-|", git_cmd(), "format-patch", '--encoding=utf8',
>>> +                     '--stdout', $patch_max > 0 ? "-$patch_max" : (),
>>> +                     $hash_parent ? ('-n', "$hash_parent..$hash") :
>>> +                     ('--root', '-1', $hash)
>>
>> This bit makes 'patch' view behave bit differently than git-format-patch,
>> which I think is a good idea: namely it shows single patch if there is
>> no cutoff.  This should be mentioned in commit message, and perhaps
>> even in a comment in code.
>>
>> Beside, if you show only single patch because $hash_parent is not set,
>> you don't need to examine $patch_max nor set limit, because you use '-1'.
>> Currently if $patch_max > 0 and !$hash_parent, you pass limit for the
>> number of patches twice.  This I think is harmless but...
> 
> I've reworked the code a bit, making the commit spec an array computed
> before passing it to the command line. The code is cleaner but
> obviously longer 8-)

Cleaner is good.
 
> The double limit worked properly, btw.

Nice to know. But should we rely on corner cases handling?

-- 
Jakub Narebski
Poland
