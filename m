From: Adam Kennedy <adam@phase-n.com>
Subject: Re: Feedback on native Win32 git from a Perl perspective
Date: Mon, 23 Jul 2007 14:50:06 +1000
Message-ID: <46A4337E.2090303@phase-n.com>
References: <46A06C7F.5010601@phase-n.com> <46a038f90707200632u1ce762c1i70eb1586e2542256@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 06:50:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICps8-0007rU-6b
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 06:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423AbXGWEuN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 00:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752617AbXGWEuN
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 00:50:13 -0400
Received: from pecan.exetel.com.au ([220.233.0.17]:51351 "EHLO
	pecan.exetel.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbXGWEuL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 00:50:11 -0400
Received: from 106.135.233.220.exetel.com.au ([220.233.135.106] helo=[192.168.37.137])
	by pecan.exetel.com.au with esmtp (Exim 4.63)
	(envelope-from <adam@phase-n.com>)
	id 1ICprx-0000kD-4S; Mon, 23 Jul 2007 14:50:05 +1000
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
In-Reply-To: <46a038f90707200632u1ce762c1i70eb1586e2542256@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53390>

Hi Martin

The situation you are in sounds somewhat similar the one we had with our 
Win32 Perl distribution releases.

The main problem is that on Windows for the most part there is just no 
concept of "first install $something" (be that a run-time, cygwin, or 
whatever).

You will find, as we did, that the expectation is that there is one 
installer, you run it, and it does everything.

For the Vanilla/Strawberry Perl installers (http://vanillaperl.com/) the 
approach we ended up with to get full toolchain functionality out of the 
box was to bundle a copy of the MinGW packages we needed, as well as 
bundling a copy of dmake.

The approach ActivePerl takes is to not bundle any of these parts, and 
expects you to download and install dmake and a compiler seperately, and 
we've had a lot of praise from people with Strawberry in particular 
because it "just works".

You run the installer, and once it finishes the cpan client works 
exactly the same as it does on Unix.

I think you may end up having to take a similar approach with git.

Create a single installer that contains both the git binaries, and 
copies of any tools you needed embedded in them (ideally in a seperate 
bin directory so that they are NOT in the path, with git referring to 
them explicitly).

Adam K

Martin Langhoff wrote:
> On 7/20/07, Adam Kennedy <adam@phase-n.com> wrote:
>> A quick review of native Win32 git provoked by the current conversation
>> amoungst the Perl core maintainers about changing version control
>> systems and whether to go with svn or git (the main two candidates).
> 
> Hi Adam,
> 
> The problem you hit is that you need the MinGW runtime -- I forget its
> name -- and that will have installed an item in your start menu. It's
> for a terminal that has all the MinGW stuff, you get a nice bash
> shell. I opened, added the GIT install directory to the path, and was
> all set.
> 
> I think Sam Vilain (aka mugwump) is going to / at / returning from
> OSCON this week, so he migth take a while to reply. Oh, I see he
> posted in your blog too.
> 
> He's been running imports of the Perl dev trees into git, they'll be
> at http://git.catalyst.net.nz/gitweb - fetchable via http at
> http://git.catalyst.net.nz/git/perl.git
> 
> My notes above are because I have _just_ been setting up git at
> aclient site on Win32. Took me a bit of fiddling as I hadn't used
> Windows in years, but I got it going...
> 
> - needs the mingw runtime - trivial
> - runs pretty well from the commandline - impressed
> - gitk and other Tk-based utilities work great ( _very_ impressed)
> but I had to fixup the wish executable name - minor
> - the http protocol wasn't supported out of the box in the version I
> got, a pain for anon checkouts, and I've seen some discussion about
> that on the list -- unsure here
> 
> In terms of http support -- IIRC the problem is handling of forked
> processes, but there might be a way to sidestep the problem.  Very
> early versions of git did some odd curl cmdline that Cogito copied.
> Serialised, slow and not one bit as smart as what we do now, but we
> can perhaps reuse some of that.
> 
> Some things you point out can be improved once things are more
> polished -- like adding links to gitk and git gui but we'd need to
> sort out how to do this in a directory context. Heh - maybe we need
> one of those explorer.exe extensions...
> 
>  From a "we are very limited Windows users" POV, no, we don't have
> TortoiseSVN unfortunately. But for developers used to mixed cli/gui
> environments, like I'm sure most Perl developers are, it'll be a
> breeze. It does need a bit of a howto though.
> 
>> For reference, the reviewer (me) has 10 years of experience with Perl
>> development across both Windows, Linux, BSD, Solaris, Mac (old and new).
> 
> I'm guess in general terms I have a somewhat similar bg  -- though I
> don't develop Perl ;-) -- and perhaps it's a bit of luck. I had
> _never_ seen MinGW (I do know CygWin) and perhaps it was a stroke of
> luck that it only took me about 45 minutes to get things going,
> figuring out the stuff noted above.
> 
> cheers,
> 
> 
> 
> martin
> 
