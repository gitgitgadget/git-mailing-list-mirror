Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 418E11F728
	for <e@80x24.org>; Fri, 24 Jun 2016 11:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbcFXLFh (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 07:05:37 -0400
Received: from forward4p.cmail.yandex.net ([77.88.31.19]:39074 "EHLO
	forward4p.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750972AbcFXLFf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2016 07:05:35 -0400
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Jun 2016 07:05:34 EDT
Received: from mxback5g.mail.yandex.net (mxback5g.mail.yandex.net [77.88.29.166])
	by forward4p.cmail.yandex.net (Yandex) with ESMTP id D8BA120ED5;
	Fri, 24 Jun 2016 13:57:07 +0300 (MSK)
Received: from web27g.yandex.ru (web27g.yandex.ru [95.108.253.236])
	by mxback5g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id Tr4nwNh82T-v6085s9n;
	Fri, 24 Jun 2016 13:57:06 +0300
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed; d=proff.email; s=mail; t=1466765826;
	bh=LbPUhsRkIrYCn453ECa7Lf0j+h5oPN+UXACmxvb3rpQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:MIME-Version:Message-Id:
	 X-Mailer:Date:Content-Transfer-Encoding:Content-Type;
	b=ZlziJeTAY1mdm6wlW6NI3GZD4VrvKx7mT6oX3Pgus3oXr84gRSKmLlJGaBrA3Pf3c
	 5KWyZbgQBnH13yGunOFOg0WQbL5AwglxhAgsvSPtf+0Wyv2tZ4e4yXo85MQuyt7wA0
	 1sjF2iYgpCth95uAE721oK7BsBpk0VStOa/6DPLE=
Authentication-Results:	mxback5g.mail.yandex.net; dkim=pass header.i=@proff.email
Received: by web27g.yandex.ru with HTTP;
	Fri, 24 Jun 2016 13:57:06 +0300
From:	=?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCe0LLRh9C40L3QvdC40LrQvtCy?= 
	<proff@proff.email>
To:	Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jakob Stoklund Olesen <stoklund@2pi.dk>,
	Sam Vilain <sam@vilain.net>,
	Steven Walter <stevenrwalter@gmail.com>,
	Peter Baumann <waste.manager@gmx.de>,
	Andrew Myrick <amyrick@apple.com>,
	Michael Contreras <michael@inetric.com>
In-Reply-To: <20160622225839.GA30828@dcvr.yhbt.net>
References: <4094761466408188@web24o.yandex.ru>
	 <20160620215253.GA16566@dcvr.yhbt.net>
	 <2518541466501215@web27h.yandex.ru> <20160622225839.GA30828@dcvr.yhbt.net>
Subject: Re: may be bug in svn fetch no-follow-parent
MIME-Version: 1.0
Message-Id: <3485951466765826@web27g.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:	Fri, 24 Jun 2016 13:57:06 +0300
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

https://s3-eu-west-1.amazonaws.com/profff/mergeinfo.zip

even ordinary merge may take up to 20-30 minutes. I'll try to trace in future

23.06.2016, 01:58, "Eric Wong" <e@80x24.org>:
> Александр Овчинников <proff@proff.email> wrote:
>>  Unfortunately this is not open source repository. I agree that it is pointless try to handle mergeinfo (because it always fails).
>>  Cases when it is expensive:
>>  1. delete and restore mergeinfo property
>>  2. merge trunk to very old branch
>>  3. create, delete, create branch with --no-follow-parent. All records in mergeinfo will be hadled like new.
>>
>>  I already patched like this and this is helpfull, works fine and fast.
>
> Thanks for the info. Patch + pull request below for Junio.
>
>>  I can share only mergeinfo property
>
> Oops, looks like your zip attachment got flagged as spam for
> my mailbox and swallowed by vger.kernel.org :x
>
> ---------8<--------
> Subject: [PATCH] git-svn: skip mergeinfo handling with --no-follow-parent
>
> For repositories without parent following enabled, finding
> git parents through svn:mergeinfo or svk::parents can be
> expensive and pointless.
>
> Reported-by: Александр Овчинников <proff@proff.email>
>         http://mid.gmane.org/4094761466408188@web24o.yandex.ru
>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>   The following changes since commit ab7797dbe95fff38d9265869ea367020046db118:
>
>     Start the post-2.9 cycle (2016-06-20 11:06:49 -0700)
>
>   are available in the git repository at:
>
>     git://bogomips.org/git-svn.git svn-nfp-mergeinfo
>
>   for you to fetch changes up to 6d523a3ab76cfa4ed9ae0ed9da7af43efcff3f07:
>
>     git-svn: skip mergeinfo handling with --no-follow-parent (2016-06-22 22:48:54 +0000)
>
>   ----------------------------------------------------------------
>   Eric Wong (1):
>         git-svn: skip mergeinfo handling with --no-follow-parent
>
>  perl/Git/SVN.pm | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
> index d94d01c..bee1e7d 100644
> --- a/perl/Git/SVN.pm
> +++ b/perl/Git/SVN.pm
> @@ -1905,15 +1905,22 @@ sub make_log_entry {
>
>          my @parents = @$parents;
>          my $props = $ed->{dir_prop}{$self->path};
> - if ( $props->{"svk:merge"} ) {
> - $self->find_extra_svk_parents($props->{"svk:merge"}, \@parents);
> - }
> - if ( $props->{"svn:mergeinfo"} ) {
> - my $mi_changes = $self->mergeinfo_changes
> - ($parent_path, $parent_rev,
> - $self->path, $rev,
> - $props->{"svn:mergeinfo"});
> - $self->find_extra_svn_parents($mi_changes, \@parents);
> + if ($self->follow_parent) {
> + my $tickets = $props->{"svk:merge"};
> + if ($tickets) {
> + $self->find_extra_svk_parents($tickets, \@parents);
> + }
> +
> + my $mergeinfo_prop = $props->{"svn:mergeinfo"};
> + if ($mergeinfo_prop) {
> + my $mi_changes = $self->mergeinfo_changes(
> + $parent_path,
> + $parent_rev,
> + $self->path,
> + $rev,
> + $mergeinfo_prop);
> + $self->find_extra_svn_parents($mi_changes, \@parents);
> + }
>          }
>
>          open my $un, '>>', "$self->{dir}/unhandled.log" or croak $!;
> --
> EW
