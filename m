X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] make 'git add' a first class user friendly interface to
 the index
Date: Fri, 01 Dec 2006 22:05:39 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612012101230.9647@xanadu.home>
References: <Pine.LNX.4.64.0612011444310.9647@xanadu.home>
 <7vpsb36yem.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sat, 2 Dec 2006 03:05:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7vpsb36yem.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32999>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqLCH-0001Nc-9P for gcvg-git@gmane.org; Sat, 02 Dec
 2006 04:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162746AbWLBDFm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 22:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162747AbWLBDFm
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 22:05:42 -0500
Received: from relais.videotron.ca ([24.201.245.36]:10850 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1162746AbWLBDFl
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 22:05:41 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9M006SLLXFFHC0@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Fri,
 01 Dec 2006 22:05:40 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Fri, 1 Dec 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > I personally think this is going to make the GIT experience lot more 
> > enjoyable for everybody.  This brings the power of the index up front 
> > using a proper mental model without talking about the index at all. See 
> > for example how all the technical discussion has been evacuated from the 
> > git-add man page.
> 
> I like the direction this is taking us.
> 
> The documentation update is in the same spirit with the sample
> rewrite of 'git diff' manpage.  We might want to tweak the
> wording to make this round of documentation updates consistent.
> 
> My preferences:
> 
>  - You used the word "changeset"; I am not sure that is a good
>    wording.  

Why not?  It is a well defined word in the SCM context, and I really 
think what is built in the index before a commit is a changeset.

But actually I'd prefer "set of changes" even better as it is more 
independent of any definition "changeset" might have.

>    The recent explanation I saw on the list and liked
>    were "you _stage_ your changes to prepare for the next
>    commit (footnote: the staging area is called 'the index')".
>    My impression was that both extremes (Linus and Carl) are
>    also Ok with this wording.

Well... dunno.

>  - We keep the word "index", and not reword it to "stage" in the
>    names of commands and options.  "to stage" is very good verb
>    to explain the _concept_, but there is no need to use
>    inconsistent wording Porcelain-ish and plumbing use to
>    describe the entity used for staging.

First I don't know if "to stage" is such a good verb.  According to 
http://dictionary.reference.com/search?q=stage I think "stage" has just 
too many definitions already, and none of which really make me think of 
GIT's index.

>    (1) New people need to learn the new concept anyway, and they
>        are intelligent enough to learn what that new concept has
>        been called for a long time in git-land at the same time.
> 
>        "The index" is the receiver of new contents to be staged;
>        conversely, "to stage" is the act of registering contents
>        to the index.

In technical docs maybe.  But I don't see the need for this wording in 
the tutorial, not even in the "add" man page.

The best way not to confuse people and making the thing look 
not too complicated is to avoid making too many explanations especially 
when they're not necessary to operate the thing.  In my 
opinion the above quote fails that test.

There are two level of languages we must be aware of.  First there is 
language to explain how to use the thing.  Next there is language to 
explain how the thing works.  And _most_ people just want to know how to 
use the thing at first.  They don't care how it works under the hood 
until they have more confidence in their own ability to use the thing 
first.  So it is really important not to mix both levels of language.

In my opinion git-add man page and the tutorial should be about how to 
use the thing, not about how the thing works.  the git-update-index is 
where to talk about how the thing works.

And even on the technical level, the quote above is wrong.  Because if 
we talk about the actual index, it doesn't contain new content only.  
The index really contains everything, including current unmodified 
content.  So on a technical level (on the "how it works" level) we 
really "update" the index to reflect a different state, and in that 
context the git-update-index could not have a better name.  It really 
says what it does.

It's just that GIT users are simply not interested to know about it.  Of 
course all subscribers of this mailing list are, but not users.  What 
users want to know is how to use the tool and the best way IMHO is to 
simply create a mental model where "all changes always have to be added 
together explicitly before they are committed with git-add."  All the 
rest are shortcuts and variants derived from that fundamental user 
model.

And eventually the more intripid users will discover that what they were 
doing without knowing initially was "updating the index".

What we really want is for users to make use of the index.  This is our 
goal.  This is how GIT is superior.

But we don't need to force users to know about how it all works.  Not 
before they are confortable with using GIT first.

>    (2) Majority of git old timers do not follow git mailing list
>        discussion closely.  They already know the concept of
>        "registering thing in the index".  We on the list are
>        just about to agree to give a good short name, "to
>        stage", for that action they have known about, in order
>        for us to make it easier to explain to new people.  That
>        should not affect the terminology the old timers are
>        accustomed to and and trained their fingers with
>        ("update-index", "diff --cached", "apply --index").

I don't see the point.  Old timers are already familiar with GIT and 
with how it works so they don't really need the tutorial nor the basic 
command's man pages.  They won't be affected at all by any change of 
"how to use" model and terminology since they obviously don't have to 
learn how to use GIT.

>    (3) I hope nobody proposes to rename "update-index" to
>        "update-stage" nor "diff-index" to "diff-stage"; that
>        would break countless number of existing third party
>        scripts old timers rely on and even new people would find
>        on the web and tempted to try out, so plumbing level
>        commands and options have to keep using the word 'index'.

Absolutely not!  Doing that would be an horrible mistake.  First because 
of the reasons you mention above, and because IMHO "stage" isn't it at 
all.  The "how it works" model is perfectly sane and it is really about 
"updating the index".  Always was, always should.

>        The option to 'git diff --cached' may need a new synonym
>        to make things consistent, but the new synonym should be
>        --index, not --staged.

It should be --index, and it should also be --commit in my opinion.  The 
first for the "how it works" model, and the second for the "how to use" 
model.  Because what _users_ want is a diff of what is going to be 
committed if they type "git commit".  Therefore I think --commit is 
really the best it could be.  Let's avoid proxy meanings like "stage" or 
whatever and get to the point.  It is --index for obvious reasons, and 
it is --commit for another but as obvious reason.

>    (4) New people will not stay newbies forever.  Using a
>        consistent word for the entity used for staging for the
>        next commit across Porcelain and plumbing is important.

I disagree.  Porcelain is about usage. Plumbing is about programming.  
It is perfectly normal that they have different concepts and words.

> > maybe add a -f/--force argument to allow for adding ignored files 
> > instead of going through git-update-index.
> 
> Yup.
> 
> > maybe add --new-only and --known-only arguments if there is a real need 
> > to discriminate between new vs updated files.  I would not suggest 
> > against it though, because if someone really has such fancy and uncommon 

Sorry, "I would suggest against" is what I meant.


