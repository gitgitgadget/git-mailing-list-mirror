Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 029231F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 19:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKLTfi (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 14:35:38 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:60077 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfKLTfh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 14:35:37 -0500
X-Originating-IP: 1.186.12.28
Received: from localhost (unknown [1.186.12.28])
        (Authenticated sender: me@yadavpratyush.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 5C6EC60003;
        Tue, 12 Nov 2019 19:35:30 +0000 (UTC)
Date:   Wed, 13 Nov 2019 01:05:28 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Jonathan Gilbert <logic@deltaq.org>
Cc:     "Pratyush Yadav me-at-yadavpratyush.com |GitHub Public/Example Allow|" 
        <172q77k4bxwj0zt@sneakemail.com>,
        Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Jonathan Gilbert <JonathanG@iqmetrix.com>
Subject: Re: [PATCH v2 2/2] git-gui: revert untracked files by deleting them
Message-ID: <20191112193528.rqjm3j42how4fae2@yadavpratyush.com>
References: <pull.436.git.1572418123.gitgitgadget@gmail.com>
 <pull.436.v2.git.1573110335.gitgitgadget@gmail.com>
 <9469beb59937f87647190cf7f56544b8c27e20b6.1573110335.git.gitgitgadget@gmail.com>
 <20191111192526.crllpe3phitneu3p@yadavpratyush.com>
 <CAPSOpYv0NNihiWF2LL=czoP7N2CGNSkB8SBNTZ65iOZVOBPqbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPSOpYv0NNihiWF2LL=czoP7N2CGNSkB8SBNTZ65iOZVOBPqbA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On 11/11/19 03:55PM, Jonathan Gilbert wrote:
> On Mon, Nov 11, 2019 at 1:25 PM Pratyush Yadav me-at-yadavpratyush.com
> |GitHub Public/Example Allow| <172q77k4bxwj0zt@sneakemail.com> wrote:
> > On 07/11/19 07:05AM, Jonathan Gilbert via GitGitGadget wrote:
> > > --- /dev/null
> > > +++ b/lib/chord.tcl
> > > @@ -0,0 +1,137 @@
> >
> > The 'class' documentation [0] suggests adding a "package require TclOO".
> > But TclOO ships by default with Tcl 8.6 and above. So, I'm not really
> > sure if we need this.
> 
> I'm not super familiar with it. I just checked what Tcl version I was
> myself running, since it's only there because of the Git Gui
> installation bundled with Git for Windows, and it was 8.6, so I
> assumed it was fair game to use. It didn't occur to me that you could
> already have an older version of Tcl installed and have Git Gui use
> it. :-) So, if I'm understanding correctly, `TclOO` as a package could
> potentially be used to allow TclOO to be used with 8.4, the minimum
> supported version you mention below, and it just happened to work for
> me in my testing without that because I have 8.6 installed but that's
> technically newer than the supported baseline?
> 
> > Nice to see some good documentation!
> >
> > One nitpick: would it make more sense to have the documentation for a
> > method/constructor just above that method/constructor? This way, when
> > someone updates the code some time later, they'll also hopefully
> > remember to update the documentation. It is much more likely to be stale
> > if all of it just stays on the top.
> 
> Hmm, what do you think of both? I was thinking of the documentation as
> a single self-contained block that someone could read to put together
> an understanding of how the chord system fits together, and split out,
> it wouldn't have that readability. What about a more abstract
> description in a block at the top, and then more technically-detailed
> & specific descriptions attached to each method?

Since you put it this way, it does make sense to create some flow. I'm 
not sure if these relatively simple methods warrant specific detailed 
documentation.

So, if you can figure out a reasonable split, that'd be great. 
Otherwise, I guess we can just stick with this.
 
> > > +oo::class create SimpleChord {
> >
> > This comes from the TclOO package, right?
> >
> > git-gui has its own object-oriented system (lib/class.tcl). It was
> > written circa 2007. I suspect something like TclOO did not exist back
> > then.
> >
> > Why not use that? Does it have some limitations that TclOO does not
> > have? I do not mind using the "official" OO system. I just want to know
> > why exactly you made the choice.
> 
> Having limited experience with Tcl, I did a Google search for "tcl
> object oriented" and ended up writing code using TclOO because that's
> what came up. Do you think it makes sense to rework this to use
> `class.tcl`, or perhaps instead the opposite: have a policy of using
> the standard TclOO going forward, and let the rest of Git Gui
> organically upgrade itself to some hypothetical point in the future
> where class.tcl is no longer used by anything?

Replacing class.tcl would be a big effort, and seeing how things stand 
as of now in terms of active contributors, I don't think it would happen 
in the near future.

So the question really boils down to "do we want to mix these two 
flavors of OO frameworks?".

If TclOO gives us some benefit over our homegrown framework, or if our 
framework is in some way hard to use, then I would certainly side on 
just sticking with TclOO.

If not, it becomes a question of taste more of less. Which 
implementation do we like more, and which more people would be 
comfortable working with. And whether mixing the two is a good idea or 
not.

That being said, I am more inclined towards using our homegrown 
framework just for the sake of uniformity if nothing else.

So in the end I guess the answer is I dunno.
 
> > More importantly, TclOO ships as part of the core distribution with Tcl
> > 8.6, but as of now the minimum version required for git-gui is 8.4. So,
> > I think we should bump the minimum version (8.6 released circa 2012, so
> > most people should have caught up by now I hope).
> 
> If I understand correctly, you mentioned that TclOO was intrinsically
> available to me because I was using Tcl 8.6, and that the manual
> recommends `package require TclOO` -- does that package dependency
> permit the use of TclOO on 8.4? If so, could that be a way to avoid
> bumping the minimum version required? Simply in the interest of
> keeping the scope of the change limited. If not, then bumping the
> minimum required version to 8.6 from 2012 doesn't seem entirely
> unreasonable either. :-)

I looked around a bit, and it seems that TclOO would not work with 8.4 
[0]. So, a version bump is needed. Unless, of course, you decide to use 
the OO framework provided by class.tcl.

The version can be bumped by editing the line git-gui.sh:33.
 
> > > +     variable Notes
> > > +     variable Body
> > > +     variable IsCompleted
> >
> > Nitpick: Please use snake_case, here and in other places.
> 
> Okay, yep -- I had copied the convention that I saw in TclOO examples,
> conscious of the fact that there might be a standard specific to
> object-oriented Tcl.
> 
> > > +     method notify_note_activation {} {
> >
> > Since this method is for internal use only, can it be made "private"?
> > Does the OO library support something like this?
> 
> I don't think so, because it's called from outside the class. What
> we'd be looking for is something like C++'s "friend" syntax. Tcl
> doesn't seem to have this. Though, I just did some further Googling,
> and saw a hint that it might be possible to bypass member security on
> a case-by-case basis, so that the method is private but `ChordNote` is
> able to call it anyway. I'll see if I can't figure this out. :-)

I don't think too much complexity/hacking is warranted for something 
like this. If you can figure out a really simple way to do it, great! 
Otherwise, just keep it like it is.
 
> > > +     method unknown {} {
> >
> > I'm a bit lost here. This method is named 'unknown', but searching for
> > 'unknown' in this patch just gives me two results: this line here, and
> > then one in a comment at the start of the file.
> >
> > From what I understand looking at the code, it some sort of a "default"
> > method, and is called when you run just `$chord_note`. How exactly is
> > this method designated to be the default?
> >
> > Also, "unknown" makes little sense in this context. Can you rename it to
> > something more meaningful? Maybe something like "activate_note"?
> 
> I think it's the fact that it is named `unknown` that makes it the
> "default" method. I think this just needs documentary comments next to
> it. The TclOO documentation says:

Yes, a comment explaining it is the default would be nice.
 
> > obj unknown ?methodName? ?arg ...?
> > This method is called when an attempt to invoke the method methodName on
> > object obj fails. The arguments that the user supplied to the method are
> > given as arg arguments. If methodName is absent, the object was invoked with
> > no method name at all (or any other arguments).
> 
> It was based on that last sentence that I interpreted `unknown` as,
> "This is a mechanism for making an object that can be called like a
> method."

Looks like this method would also be called if someone misspelled a 
method name for this object. So say if someone by mistake writes 

  $note is_activate

this method would be called. This is a clear bug. So, add a check here 
to make sure 'methodName' is actually absent. And if it isn't, display 
an error. Displaying an error to the user on a programmer error can get 
annoying. But since we don't have something like assertions in git-gui 
yet, maybe that's the best way to get bugs noticed.
 
> > > +             if {!$IsActivated} {
> > > +                     set IsActivated 1
> > > +                     $Chord notify_note_activation
> > > +             }
> > > +     }
> > > +}
> >
> > From what I understand, the "Note" object is effectively used as a
> > count. There is no other state associated with it. When I first heard of
> > your description of this abstraction, I assumed that a Note would also
> > store a script to execute with it. So, when you "activate" a note, it
> > would first execute the script, and then mark itself as "activated", and
> > notify the chord. Would that abstraction make more sense?
> >
> > I don't really mind keeping it this way, but I wonder if that design
> > would make the abstraction easier to wrap your head around.
> 
> I learned about the concept of chords and notes from an experimental
> language that Microsoft created many years back called "Polyphonic C#"
> (which in turn got rolled into "Cw" (C-omega)), and in that
> abstraction, the idea was that, well, as a baseline, for starters, we
> have methods and each one, conceptually, has an entrypoint with a
> certain set of parameters, and when you call that entrypoint, the
> parameters are all set and the body runs. With a "chord", you have
> more than one entrypoint attached to the same body -- the entrypoints
> themselves don't have any logic associated with them individually.
> Each note has its own parameter list, and when all the notes have been
> called, the body is run with _all_ of those parameters.
> 
> I drew some ASCII art, don't know if it'll translate in the message,
> but here goes :-)
> 
> Basic method (or, if you will, a "chord" with only one "note"):
> 
>            (caller)
>               |
>     void Add(int X, int Y)
>               |
>       { output(X + Y) }
> 
> A "chord" with two "notes":
> 
>         (caller)                (caller)
>             |                       |
>     void AddX(int X)         void AddY(int Y)
>             |                       |
>             `-----------.-----------'
>                         |
>                 { output(X + Y) }
> 
> The specific details differ from what I've written here. In Polyphonic
> C#, you don't have to instantiate a chord, you simply start calling
> methods, and the runtime matches up complete sets dynamically. (Just
> thinking through the implications of this, if the notes aren't all
> called at exactly the same rate this obviously leads very easily to
> bugs that chew up all memory on incomplete chords. :-P) Also,
> Microsoft's language has parameters to each of the notes that are
> _all_ passed to the body at once. My implementation here is a "simple"
> chord, I didn't bother with arguments, as they aren't needed in this
> usage :-) I also found it much simpler to think of implementing the
> chord with the activations being explicit instead of implicit. So
> instead of saying up front, "Here is my method body and here are its 3
> entrypoints", with this implementation the chord is a dynamic object,
> you say "Here is my method body" and get back a thing that you can
> start tacking entrypoints onto.
> 
> But, a "note" in a SimpleChord isn't a counter, it's a latch. The
> chord itself is acting sort of like a counter, in that all the notes
> need to be activated, but because the notes are latches, activating a
> note repeatedly has the same effect as activating it once. There's no
> way for one note to interfere with other notes, which wouldn't be the
> case if it literally were just a counter.

Makes sense.
 
> It seems to me that a chord where each note has a script of its own is
> actually basically just a class with methods, I guess with a common
> joined epilogue?:
> 
>         (caller)                (caller)
>             |                       |
>     void AddX(int X)         void AddY(int Y)
>             |                       |
>    { script for AddX }      {script for AddY }
>             |                       |
>             `-----------.-----------'
>                         |
>                 { common tail?? }

Thanks for explaining.

I had a slightly different mental model of the abstraction. The figure 
here is what I had in mind, with the exception being that the two 
functions that the two callers call are independent of each other.

To put it in more detail, what I was thinking of was that you'd create a 
bunch of scripts that had to be evaluated separately, independent of 
each other. Each script is associated with a note. Activating a note 
runs that script. And when all the notes are activated, the common tail 
is executed.

As far as I see, the use of the chord in the patch has just two 
independent operations that need to run a common tail once both are 
complete.

That's not to say it has to be done this way. Your way works just as 
well, just in a slightly different way :)
 
> The whole point is that the notes are conceptually different "headers"
> into _the same_ body. When you call a note of a chord, it is because
> you want the _chord_'s script to run, and the chord is acting as a
> construct that says "okay, yes, I'll satisfy your request that I
> execute, but you'll have to wait, because I'm going to satisfy _all_
> your requests in one go".
> 
> > >       $::main_status stop
> > > -     unlock_index
> > > -     uplevel #0 $after
> >
> > There is a call to unlock_index in the body of the if statement above
> > too. Do we want to remove that too, or should it be left alone?
> >
> > That codepath seems to be taken when a major error happens, and we just
> > resign to our fate and get a fresh start by doing a rescan and syncing
> > the repo state. So it is quite likely whatever operation we were doing
> > failed spectacularly.
> >
> > Maybe the answer is to swallow the bitter pill and introduce a
> > switch/boolean in `_close_updateindex` that controls whether the index
> > is unlocked or not. We unlock it when the if statement is not taken, and
> > keep the current codepath when it is. I call it a "bitter pill" because
> > I'm usually not a huge fan of adding knobs like that in functions. Makes
> > the function harder to reason about and makes it more bug prone.
> >
> > If you can think of a better/cleaner way of working around this,
> > suggestions are welcome!
> 
> Hmm, so, yeah, the entire if statement only occurs if it can't close
> the file descriptor. Is that something that actually happens? If so,
> then it should perhaps be throwing an exception, because having
> started a rescan is probably more than the caller bargained for. That
> would prevent the callers from unlocking the index out from under the
> rescan, and also cancel any other processing they might be doing that
> is probably making bad assumptions with a rescan running.

This seems like defensive programming. It is accounting for something 
_really bad_ happening.

If closing the file descriptor fails, it means the buffer was not 
flushed properly for some reason. Whatever operations we thought we did 
were potentially not completed. So, we just discard all 
assumptions/state, and get a fresh start by doing a rescan. This was 
introduced in d4e890e5 ("git-gui: Make sure we get errors from 
git-update-index", 23-10-2007). The commit message says:

    I'm seeing a lot of silent failures from git-update-index on
    Windows and this is leaving the index.lock file intact, which
    means users are later unable to perform additional operations.

    When the index is locked behind our back and we are unable to
    use it we may need to allow the user to delete the index lock
    and try again.  However our UI state is probably not currect
    as we have assumed that some changes were applied but none of
    them actually did.  A rescan is the easiest (in code anyway)
    solution to correct our UI to show what the index really has
    (or doesn't have).

Since this is a _really_ old commit, I'm not sure if the problem still 
exists today though.

So, this recovery code has to go somewhere. Yes, a rescan is certainly 
more than what the caller wanted, but it is better than working on an 
inconsistent in-memory state of the repo.

The question then becomes where the best place to do so is. This seems 
like a good one if we can get our locking requirements to work with it 
properly.

The glaring problem is that we don't want the rescan to run while the 
deletion task is still running because they will interfere with each 
other. Also, deletion expects the index to be locked, so the rescan and 
deletion should be mutually exclusive.

One quick hack I can think of is to throw an error from this function, 
and let the caller handle it. Then, in the callers that don't have the 
deletion task to worry about, they just call the rescan (to be more 
specific, the body of the if statement - moved to its own function). The 
callers that do have to worry about the deletion somehow schedule it 
after the deletion process finished. Or, they somehow cancel the 
deletion operation, and then run the rescan.

Waiting till the deletion is over can probably be done by polling the 
lock in an `after idle...`.

This is what I can think of at first glance. Maybe I'm missing a better 
and cleaner way?
 
> > >       if {$update_index_cp >= $total_cnt} {
> > > -             _close_updateindex $fd $after
> > > +             _close_updateindex $fd $do_unlock_index $after
> >
> > _close_updateindex takes only one argument, and you pass it 3.
> > $do_unlock_index does not seem to be defined anywhere. $after is
> > evaluated just after this line, and _close_updateindex doesn't accept
> > the argument anyway. I suspect this is a leftover from a different
> > approach you tried before this one.
> 
> It is indeed, oops!
> 
> > Also, unlike all the other places where _close_updateindex is used, this
> > one does not make a call to unlock_index. Is that intended? IIUC, it
> > should be intended, since this is the part which uses the "chord", but a
> > confirmation would be nice.
> 
> Intentional, yes. I'll see if there's a concise way to document this.
> 
> > > +     # Common "after" functionality that waits until multiple asynchronous
> > > +     # operations are complete (by waiting for them to activate their notes
> > > +     # on the chord).
> >
> > Nitpick: mention what the "multiple asynchronous operations" are exactly
> > (i.e, they are the deletion and index checkout operations).
> 
> Okeydoke.
> 
> > >       set after {}
> >
> > 'after' seems to be an unused variable. This line can be deleted.
> 
> Good catch.
> 
> > > +             if {($deletion_error_cnt > 0) && ($deletion_error_cnt <= [MAX_VERBOSE_FILES_IN_DELETION_ERROR])} {
> >
> > Nitpick: please split the line into two.
> 
> Will do.
> 
> > > +                     set error_text "Encountered errors deleting files:\n"
> >
> > Wrap the string in a `mc [...]` so it can be translated some time in the
> > future.
> 
> Ah, yes, I did that with most messages, this was an oversight.
> 
> > > +proc MAX_VERBOSE_FILES_IN_DELETION_ERROR {} { return 10; }
> >
> > Why use a procedure, and not a global variable? My guess is to make it
> > impossible for some code to change this value by mistake. Do I guess
> > correctly?
> 
> A variable is by definition not a constant. This is the pattern that
> came up when I did a search for how one makes a constant in Tcl. ""\_(
> ``_/ )_/""
> 
> Making it a procedure means that if someone wants to put actual logic
> behind it in the future, it's already being called as a proc.

Makes sense.
 
> > Wew! This took longer than I expected ;)
> >
> > Tested on Linux. Works fine after fixing the extra arguments passed to
> > `_close_updateindex`. Thanks.
> 
> Yeah, I did run things as I was changing them to verify, and felt like
> I covered everything, I'm surprised I didn't bump into that, obviously
> I didn't cover everything after all. Perfect demonstration of why
> developers should never be exclusively responsible for testing their
> own code :-D
> 
> Let me know w.r.t. which OO framework to employ and what that means
> for minimum required versions and/or package references.
> 
> Thanks very much,
> 
> Jonathan Gilbert

[0] https://wiki.tcl-lang.org/page/MeTOO

-- 
Regards,
Pratyush Yadav
