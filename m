From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv3 1/4] gitweb: introduce remote_heads feature
Date: Sun, 16 Nov 2008 18:40:19 +0100
Message-ID: <cb7bb73a0811160940wd3624ccl4f1f184cff729b6@mail.gmail.com>
References: <1226842089-1159-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1226842089-1159-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <7vvdun3827.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>,
	"Petr Baudis" <pasky@suse.cz>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 18:41:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1lcv-0006Sd-4c
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 18:41:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbYKPRkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 12:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbYKPRkW
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 12:40:22 -0500
Received: from qb-out-0506.google.com ([72.14.204.231]:11351 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbYKPRkV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 12:40:21 -0500
Received: by qb-out-0506.google.com with SMTP id f11so2093345qba.17
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 09:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=pC7Uya9CY1F1+SQkN+PBkdzSgndZCKiRSq3wSlFxwqE=;
        b=rg3CI+J0TfSmcXBukCzF92dZjVSDKTp9eUGZO6f77X0hoXPAG+kIIwsBjqPE6WEkPm
         moa4uojYTLvE4XBHyjjBSI19FLtFvwrYk/ulglhr1rjaL9feAbOuR3FPzbVeA4ZowBak
         mLI1I5GUiwxqo9aOA2Xp48/1i5Vz8R2YRkw64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FwPmanJa4qYDw2Ejj8KbQATdHAdytxJAZ17xnM2wi9v87FguGX6v6Brt5jvLcGxBZM
         ey46j7dKFeBM8LVPVytqO+/gUOw5fHFj3wf9BnPX3s9dzW7CkyFPYycub8nDRBGcNO1x
         FDJXG7/NojVsmsKbGTY1t2LVmLqneuBZg6R2g=
Received: by 10.210.40.10 with SMTP id n10mr3166572ebn.102.1226857219446;
        Sun, 16 Nov 2008 09:40:19 -0800 (PST)
Received: by 10.210.132.16 with HTTP; Sun, 16 Nov 2008 09:40:19 -0800 (PST)
In-Reply-To: <7vvdun3827.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101146>

On Sun, Nov 16, 2008 at 6:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> With this feature enabled, remotes are retrieved (and displayed)
>> when getting (and displaying) the heads list.
>
> Wouldn't it be easier to read if you just said: "Include 'remotes' in the
> heads_list", because:

[snip]

> I am also suggesting to drop "With this feature enabled"; I do not think
> of a case where somebody runs gitweb on a repository with refs/remotes and
> does not want to show them.

[snip]

> When proofreading what you've written, it is usually a good idea to read
> it without anything you wrote in parentheses once, and then re-read it
> with parentheses removed (but the stuff in your parentheses kept), and
> compare which one you like better.  More often than not, you'd find that
> either parenthesized parts are unnecessary, or they are important enough
> that you shouldn't put them in parentheses.

Good points, I'll rewrite the commit messagge following the suggestions.

>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index b0d00ea..e1f81f6 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -329,6 +329,18 @@ our %feature = (
>> ...
>> @@ -410,6 +422,18 @@ sub feature_pickaxe {
>> ...
>> +sub feature_remote_heads {
>> ...
>> +}
>
> When would somebody want to disable this?  Please explain; I'd like to
> understand the motivation behind it.
>
> One argument for making this feature optional I can think of is to retain
> backward compatibility because we didn't show them before, but I would say
> that is a weak argument.  Before release 1.5.0 made the separate remotes
> layout the default, everything was in refs/heads/, so you could even argue
> that this "fixes" the gitweb bug introduced in that release that stopped
> showing the branches you copied from elsewhere.

For example, because the only remote for the tree is the author's own
private tree, or because the only remotes are the mirrors on gitorious
or github. In both cases, there would be no reaso to waste resources,
bandwidth and screen estate loading and displaying the remote
references.

OTOH, it might make sense to make remote_heads enabled by default (and
overridable).

>> @@ -2660,10 +2684,12 @@ sub git_get_heads_list {
>>       my $limit = shift;
>>       my @headslist;
>>
>> +     my $remote_heads = gitweb_check_feature('remote_heads');
>> +
>>       open my $fd, '-|', git_cmd(), 'for-each-ref',
>>               ($limit ? '--count='.($limit+1) : ()), '--sort=-committerdate',
>>               '--format=%(objectname) %(refname) %(subject)%00%(committer)',
>> -             'refs/heads'
>> +             'refs/heads', ( $remote_heads ? 'refs/remotes' : '')
>>               or return;
>>       while (my $line = <$fd>) {
>>               my %ref_item;
>
> Imagine a later version of git may introduce 'refs/frotz/nitfol' namespace
> hierarchy that is commonly known as the 'xyzzy class' and is also useful
> to show.  Wouldn't it be easier to update gitweb to match such a change if
> this part of the code were written like this?
>
>        my %head_class = ('refs/heads' => 'head');
>        $head_class{'refs/remotes'} = 'remote'
>                if ( this feature is used );
>        $head_class{'refs/frotz/nitfol'} = 'xyzzy'
>                if ( the xyzzy class is used);
>        open my $fd, ... (keys %head_class);
>
>> @@ -2674,8 +2700,9 @@ sub git_get_heads_list {
>>               my ($committer, $epoch, $tz) =
>>                       ($committerinfo =~ /^(.*) ([0-9]+) (.*)$/);
>>               $ref_item{'fullname'}  = $name;
>> -             $name =~ s!^refs/heads/!!;
>> +             $name =~ s!^refs/(head|remote)s/!!;
>>
>> +             $ref_item{'class'} = $1;
>
> And then outside the loop, you'd prepare:
>
>        my $headpat = join('|', map { quotemeta($_) } keys %head_class);
>
> and inside the loop you would do:
>
>        if ($name =~ s{^($headpat)/}{}) {
>                $ref_item{'class'} = $head_class{$1};
>                ...
>
> Only one place to configure the list of classes, and make everybody use
> that list instead of hardcoding the assumption that there are two and only
> two kinds of things "head" vs "remote".

Ah, good point. This change, and the one about extending
git_get_heads_list, could also be turned into prelliminary patches to
the actual remote_heads feature.

-- 
Giuseppe "Oblomov" Bilotta
