From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: ref markers link to named shortlogs
Date: Tue, 26 Aug 2008 10:15:35 +0200
Message-ID: <200808261015.37023.jnareb@gmail.com>
References: <1219341860-4913-1-git-send-email-giuseppe.bilotta@gmail.com> <200808242237.53953.jnareb@gmail.com> <cb7bb73a0808251628q6af52292sc296fb63565b6eaa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Lea Wiemann" <lewiemann@gmail.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@ucw.cz>, "Junio C Hamano" <gitster@pobox.com>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 10:19:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXtjQ-0003L9-5l
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 10:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779AbYHZIPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 04:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752737AbYHZIPq
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 04:15:46 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:33525 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbYHZIPp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 04:15:45 -0400
Received: by ey-out-2122.google.com with SMTP id 6so258047eyi.37
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 01:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=bgGD3e4IBpABX6KTcMkcJzqiQunbSmn84zRuH6Ld+Zg=;
        b=i4ufEwZLIC7sDcn07XyYCZCf9Eu35RCCKhD8h+BycFnrGWj+EqM2Y6xXdn78fmN5LE
         +VsLxG9pErrKLlLKtvIEUJhDIU/c4Mk72M5g1vvsQVHWOVQCSkXy/+62UHY7XcZQe1bp
         d8Sd90GjKlJYL/ih/vfn2RzVILVchjjOcxHuM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=oVZwdXrbas6hy6DTAmhv2YkzNONriXPD+weRUOgIK5ct6K8BxWccv6b7UvYe/E61a1
         ozT8tpVrAbMF2M67UkaxmEAPH14t5ARgF8hPzU2FKRs51JBxO0nR/zZgyM/a7qik8Vqf
         d86TjxqSa2Y7Ox0cjq0eSO7gl4I+vh40tDQwo=
Received: by 10.210.23.3 with SMTP id 3mr4233241ebw.41.1219738543601;
        Tue, 26 Aug 2008 01:15:43 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.254.77])
        by mx.google.com with ESMTPS id 10sm6119515eyd.6.2008.08.26.01.15.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Aug 2008 01:15:42 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0808251628q6af52292sc296fb63565b6eaa@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93724>

On Tue, 26 August 2008, Giuseppe Bilotta wrote:
> On Sun, Aug 24, 2008 at 10:37 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> Lea Wiemann wrote:
>>> Giuseppe Bilotta wrote:
>>>> +                   my $git_type = git_get_type($ref);
>>>> [...]
>>>> +                           $cgi->a({-href => href(action=>$view{$git_type} || $git_type, hash=>$name)}, $name) .
>>>
>>> Since some of this thread seems to be about performance, you might just
>>> make this a link to action => 'object' (and save the git_get_type call)
>>> and let gitweb Do The Right Thing when the link is followed.
>>>
>>> [Disclaimer: Haven't read the whole thread, and haven't checked if
>>> action=object is actually doing the right thing here.]
>>
>> First, only the first patch (and perhaps second) called git_get_type;
>> v4 and v5 do not.  Second, link to 'object' action would not do the
>> right thing; we want either 'shortlog' or 'tag' view, not 'commit'
>> or 'tag' view.
>>
>> What this patch does is making ref markers in the log-like views, and
>> in the commit subject line headers in other view be "hidden links" to
>> either 'shortlog' (in the case of ref being head/branch, or lightweight
>> tag), or to 'tag' view in the case of annotated tag.  We rely on the
>> fact that we know what type of object refs points to (currently it is
>> only 'commit', which might change, but the fact that we know type of
>> object for which we show marker would not change), and the fact that
>> tags point to given object only indirectly, and only tags can point
>> indirectly (^{} suffix in "git show-ref --dereference", and
>> "git ls-remote .", and $GIT_DIR/info/refs).
> 
> However, Lea's idea has its own merit. I hacked up a patch series that
> implements a git_marker_view() function (or fucntion as the shortlog
> says 8-P) and *that* one is used for ref markers, you can see it (3
> patches) here: http://git.oblomov.eu/git/shortlog/heads/gitweb/shortlog..heads/gitweb/refmark
> [it's on top of other stuff but it's actually independent from the
> other stuff].
> 
> The advantage of this approach is that you actually it's more flexible
> in case future expansions lead to other differences in object vs
> marker view (currently the only difference is commit => shortlog):
> such differences just need to be added to the appropriate %views hash.
> 
> The disadvantage is that we don't care about the difference between
> lightweight and annotated tags, so there is no more visual difference
> about it, something which patch v5 does. This could of course be
> addressed separately as needed.

NAK. For me using 'objectview' action, i.e. deciding on action based
on the type of object, it is a bad idea. Let me explain in more detail.

First, I pretty much think that user would want to know if clicking
on ref marker would lead him/her to 'tag' view, or to 'shortlog' view.
So having visual difference is something that we want to have.  And
if we do that when generating link, why not go one extra step and
in addition to visual difference also use different action in link?


Second, for me the whole idea of deciding on action based on the type
of object, either via 'object' view/action or via actionless gitweb URL
is either necessary evil or a tradeoff.  We use it because of the
following issues:

 * Calculating proper action during link generation via git_get_type()
   is costly; it is additional fork (this can be avoided by using
   'reuse connection' get type from Lea gitweb caching work), extra
   CPU load, and extra I/O hit.  If it *cannot be avoided* (which is
   not the case of ref markers links) it is better to defer this cost
   till user actually follows the link.  This feature is used for
   sha-1 committags (turning something that looks like sha-1 into
   gitweb hyperlink) and for links to symbolic links targets in 'tree'
   view (where link target can not exist - dangling symlink, or can
   lead to file or directory).

   (That is necessary evil part).

 * Guessing action based on type of objects allows gitweb to be more
   robust, support URL editing/mangling more easily, and aid the
   creation of shortcuts to git repositories (e.g. in bugtracker)
   more easily (see commit 7f9778b19b07601ae81).  Currently it is
   done in dispatch phase, and does not do redirection.

   (That is tradeoff: more robust and extra feature for extra get type).

BTW. one thing that can be done is consolidation of "guessing action"
code: it is done by simply calculating what is to put in $action during
dispatch, or is done in 'object' view to calculate redirect URL with
proper action.  I have tried to bring them together, but patches were
I think lost in the noise.

> So, should I resend v5 with the small change about refs canonical
> form, or is somebody else doing it? Or is the new idea as implemented
> in the above mentioned changeset preferrable? Should I send that
> patches to the mailing list?

IMHO v5 with small change making refs canonical (hash=>"refs/$ref")
is preferred way to do this.  You can send v6 patch or I can send
it (I planned doing this today).
 
> Let me know, I've got plenty more stuff ready for gitweb and I'm eager
> to see them accepted upstream 8-D

First, the great problem with gitweb patches as of today is if Lea
Google Summer of Code 2008 work on gitweb caching would be accepted
(merged in) into git repository; I pretty much think that any gitweb
improvements would be "incompatibile" (read: causing conflicts) with
'gitweb caching' patch covering such large parts of code... but
I might be mistaken about that.

Second, I have planned on sending "gitweb TODO and wishlist", or 
"what's cooking in gitweb", with links to threads on git mailing
list, and sometimes explanation why some feature should wait on
infrastructure improvements, such as consolidating log-like views
code.


Thank you for contributing to gitweb...
-- 
Jakub Narebski
Poland
