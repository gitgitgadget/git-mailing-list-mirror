From: "Michael Hutchinson" <m.j.hutchinson@gmail.com>
Subject: Re: git integration with monodevelop
Date: Wed, 12 Nov 2008 18:56:47 -0500
Message-ID: <aec34c770811121556y34465436i9ffb5e29dbf203a7@mail.gmail.com>
References: <491AAE6D.8030304@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: monodevelop-list@lists.ximian.com, Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: "Andreas Ericsson" <ae@op5.se>
X-From: monodevelop-list-bounces@lists.ximian.com Thu Nov 13 00:58:11 2008
Return-path: <monodevelop-list-bounces@lists.ximian.com>
Envelope-to: gcgmm-monodevelop-list@m.gmane.org
Received: from galactus.ximian.com ([130.57.169.22] helo=lists.ximian.com)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0Pb2-00010i-V4
	for gcgmm-monodevelop-list@m.gmane.org; Thu, 13 Nov 2008 00:58:05 +0100
Received: from galactus.ximian.com (localhost.localdomain [127.0.0.1])
	by lists.ximian.com (Postfix) with ESMTP id 22BC31CFD53;
	Wed, 12 Nov 2008 18:56:54 -0500 (EST)
X-Original-To: monodevelop-list@lists.ximian.com
Delivered-To: monodevelop-list@lists.ximian.com
Received: from herald.ximian.com (frontgate.ximian.com [130.57.169.19])
	by lists.ximian.com (Postfix) with ESMTP id 4C0F21CFB7A
	for <monodevelop-list@lists.ximian.com>;
	Wed, 12 Nov 2008 18:56:52 -0500 (EST)
Received: by herald.ximian.com (Postfix, from userid 2601)
	id 2BC6D70026; Wed, 12 Nov 2008 18:56:52 -0500 (EST)
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by herald.ximian.com (Postfix) with ESMTP id B612170026
	for <monodevelop-list@lists.ximian.com>;
	Wed, 12 Nov 2008 18:56:48 -0500 (EST)
Received: by wa-out-1112.google.com with SMTP id j5so407290wah.4
	for <monodevelop-list@lists.ximian.com>;
	Wed, 12 Nov 2008 15:56:47 -0800 (PST)
Received: by 10.114.57.15 with SMTP id f15mr6448502waa.38.1226534207079;
	Wed, 12 Nov 2008 15:56:47 -0800 (PST)
Received: by 10.114.155.5 with HTTP; Wed, 12 Nov 2008 15:56:47 -0800 (PST)
In-Reply-To: <491AAE6D.8030304@op5.se>
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on 
	frontgate.ximian.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.1 required=5.0 tests=DNS_FROM_RFC_POST,MY_OBFUJ,
	MY_OBFUT,MY_OBFUZ,RCVD_BY_IP,SPF_HELO_PASS,SPF_PASS version=3.0.3
X-BeenThere: monodevelop-list@lists.ximian.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: MonoDevelop discussion mailing list
	<monodevelop-list.lists.ximian.com>
List-Unsubscribe: <http://lists.ximian.com/mailman/listinfo/monodevelop-list>, 
	<mailto:monodevelop-list-request@lists.ximian.com?subject=unsubscribe>
List-Archive: <http://lists.ximian.com/pipermail/monodevelop-list>
List-Post: <mailto:monodevelop-list@lists.ximian.com>
List-Help: <mailto:monodevelop-list-request@lists.ximian.com?subject=help>
List-Subscribe: <http://lists.ximian.com/mailman/listinfo/monodevelop-list>,
	<mailto:monodevelop-list-request@lists.ximian.com?subject=subscribe>
Sender: monodevelop-list-bounces@lists.ximian.com
Errors-To: monodevelop-list-bounces@lists.ximian.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100835>

On Wed, Nov 12, 2008 at 5:22 AM, Andreas Ericsson <ae@op5.se> wrote:
> Recently, I've started learning C#. More for fun than anything else,
> but one of the mono core devs sniffed me out and said they've been
> thinking of porting jgit to C# to get a working IDE integration in
> monodevelop. Currently, the only option available (with IDE
> integration anyways) to the poor C# devs is either Microsoft's
> crappy VSS, or the less crappy but still far from fantastic
> Subversion.

I'm glad you're interested :-)

We do have an interface in MD for integrating VCS providers, and
although the only existing one is SVN, I believe some users are
working on bzr and perforce addins. I'd prefer to see git get
established as the default (D)VCS ...

Currently, to implement  a VCS provider one needs to subclass
VersionControlSystem, as demonstrated by the SVN provider:
http://anonsvn.mono-project.com/viewvc/trunk/monodevelop/main/src/addins/VersionControl/MonoDevelop.VersionControl.Subversion/MonoDevelop.VersionControl.Subversion.addin.xml?view=markup.
We may need to extend the interfaces in order to expose more
DVCS-specific features, but I think it's best to find and fix these as
needed rather than speculatively implementing things.

> So in an effort to learn C#, I've decided to play along with this
> (hopefully with some help from the MonoDevelop team), but it seems
> to me that the best place to start is the fledgling libgit2 and link
> that with git-sharp. The primary reason for this is ofcourse that I
> think it'd be a terrible waste to have yet another from-scratch
> implementation of git in a new language (ruby, java, C#, C...). The
> secondary reason is that it would be neat to have more OSS projects
> use my favourite scm.

That's actually one of the reasons we'd like a full managed
implementation --it'd be trivial to include to with cross-platform
Mono-based apps without worrying about architecture, C dependencies,
etc. For example, Tomboy could use git to store its notes, so users
would have a versioned history and better synch/merge. Then, for
example, you could build a Silverlight version that would have full
history in local storage.

> Besides, getting something to rely on libgit2 early on is probably
> the best way to get more people interested in making development of
> it proceed rapidly.
>
> Thoughts anyone?

I hadn't heard of libgit2 (it looks pretty recent) but it looks
interesting -- at least stable APIs would no longer be a worry.
However, I think fully managed is the way to go, from the point of
view of much easier dependencies (on windows, mac, silverlight and
older linux distros) and licensing.

-- 
Michael Hutchinson
http://mjhutchinson.com
