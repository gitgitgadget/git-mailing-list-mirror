From: Lachlan Deck <lachlan.deck@gmail.com>
Subject: Re: git svn branch tracking + ignore paths
Date: Wed, 28 Oct 2009 14:00:55 +1100
Message-ID: <AC7B0CB1-1B14-4EAE-A6B6-D0845EACE626@gmail.com>
References: <41F0F1D6-4F99-4828-9259-1B2BDC689747@gmail.com> <32541b130910271616ha861d08xa4b90b822d31f0ea@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 04:01:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2ymf-0002CK-3G
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 04:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbZJ1DBC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 23:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbZJ1DBB
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 23:01:01 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:35609 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932431AbZJ1DBA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 23:01:00 -0400
Received: by ewy4 with SMTP id 4so374842ewy.37
        for <git@vger.kernel.org>; Tue, 27 Oct 2009 20:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=l/CQFTXhJ9V0/xjUbvggqhk2TasroZdM6q35wdDE4Ow=;
        b=l2pf3TdXZMUOc/vLLbDZruysGS/+9O84yNfZzkizaqID4roztamsv9xmdje0nWZ0+9
         XqkX+MUmJyUHDqZUCs/upirpXsTLmD2GyeaX7FsIjkY1E7nqQAF+FURIDfuv8Du1DQaz
         v2Rz60ojqsW6ycSO7IX21W+S75Cnqsr2c++n0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=xDJMQ5bBbCaR89fbRABIw/eiHtE3MT033poK2I8VZ/fy9RgvVglChTxofnnMdGD6EW
         mo/OCD1nq9VKGxSa/JFD+YQL66bRfVLgiNGgO868VUPEAHxnt4qUG3HWEipkbKFempN3
         d0FX3vGG2gx0RHD/zhzUpeG/JszFVeOqYcsCA=
Received: by 10.216.90.11 with SMTP id d11mr139590wef.187.1256698864137;
        Tue, 27 Oct 2009 20:01:04 -0700 (PDT)
Received: from ip-144.ish.com.au (ip-144.ish.com.au [203.29.62.144])
        by mx.google.com with ESMTPS id 10sm6020501eyd.0.2009.10.27.20.01.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Oct 2009 20:01:03 -0700 (PDT)
In-Reply-To: <32541b130910271616ha861d08xa4b90b822d31f0ea@mail.gmail.com>
X-Mailer: Apple Mail (2.1076)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131401>

On 28/10/2009, at 10:16 AM, Avery Pennarun wrote:

> On Tue, Oct 27, 2009 at 7:00 PM, Lachlan Deck  
> <lachlan.deck@gmail.com> wrote:
>> I'm wondering if it's possible to create a branch (starting as  
>> local but
>> later on pushed to svn) that essentially stays in sync with the  
>> main branch
>> (svn trunk) but both (a) ignores pulling in certain paths from  
>> trunk and (b)
>> provides a few extra paths of its own (some of which overlap with  
>> those
>> ignored from trunk) and (c) only pushes to trunk paths that are  
>> relevant for
>> trunk (i.e., not specifically ignored)?
>>
>> If someone's able to share how they'd go about setting this up  
>> that'd be
>> great.
>
> This sounds like a generally scary idea.  Perhaps if you described
> your problem at a higher level (what are you really trying to
> achieve?) there would be a less scary way to do it.

:) Sure. Essentially a project that I'm contributing to has both maven  
poms and ant/lib-based configs (with the ant ones as default for  
eclipse .project etc files). I'd like to be able to import the  
projects with maven into Eclipse to work on things but without  
committing back changes to eclipse .project/.classpath/.settings/*.

So I'm hoping for a fairly transparent process.

> That said, if you *really* need this... one option that comes to  
> mind is:
>
> 1. extract the history from svn into git using 'git svn' as usual.
>
> 2. extract the subtree of svn that you're interested in (if you're
> lucky enough that you only need one subtree) by using 'git subtree
> split'.  This creates a new branch or new git repo, depending how you
> do it.
>
> 3. Create a third project that will host your new work with extra
> subtrees that you don't want.  Use 'git subtree add' and 'git subtree
> merge' to keep this up to date with the stuff you extracted in step 2.
> (Repeat steps 1-3 as necessary to keep your project up to date with
> the svn project.)
>
> 4. When you want to merge your own changes back into svn, first
> extract them from your own project (step 3) using 'git subtree split'.
> Then merge those changes into the main project (step 1) using 'git
> subtree merge'.  Then use git-svn to upload them to the main svn repo.
>
> You can save yourself some steps if you import the *entire* svn
> project into your own project, rather than trying to trim it on
> import.  That way you only have to split when going from #3 to #1, not
> in the other direction, and you don't need repository #2.
>
> If all this sounds crazy, it probably is.  Maybe see if you can come
> up with a way to avoid trying to do this altogether.
>
> Good luck... :)

Sounding scary. But if the above description of what I'm trying to  
achieve helps in finding a simple way to work I'm all ears :)

Thanks.

> Avery
>
> [1] http://github.com/apenwarr/git-subtree

I'll check this out anyway. Thanks.

with regards,
--

Lachlan Deck
