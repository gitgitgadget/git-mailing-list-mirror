From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH 2/2] cvsimport: cleanup commit function
Date: Tue, 23 May 2006 20:13:10 +1200
Message-ID: <46a038f90605230113x2f6b0e4bq5a2ea97308b495e0@mail.gmail.com>
References: <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com>
	 <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com>
	 <44720C66.6040304@gentoo.org>
	 <46a038f90605221241x58ffa2a4o26159d38d86a8092@mail.gmail.com>
	 <Pine.LNX.4.64.0605221256090.3697@g5.osdl.org>
	 <20060522214128.GE16677@kiste.smurf.noris.de>
	 <7v8xotadm3.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90605221615j59583bcdqf128bab31603148e@mail.gmail.com>
	 <20060523065232.GA6180@coredump.intra.peff.net>
	 <20060523070007.GC6180@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue May 23 10:13:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiS0x-0006LS-OH
	for gcvg-git@gmane.org; Tue, 23 May 2006 10:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWEWINM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 04:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWEWINM
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 04:13:12 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:15306 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932104AbWEWINK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 04:13:10 -0400
Received: by wr-out-0506.google.com with SMTP id i30so1280931wra
        for <git@vger.kernel.org>; Tue, 23 May 2006 01:13:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pc387zIy/F2ASpSBcwQWgsyT7Aqyc9zYE5BhZtMHUWsPSkFRzmQxzIyliYTiBBnAWQK6boWBtfsmdSomjiRwEG0FCLw6wgt6zek+MsnDTWyjXlTtKaAIegQA4UPtex1zGpBVtpM33x7uwGYYFuRBWw3wKi+jUZMUoKQpAfWxmos=
Received: by 10.54.62.6 with SMTP id k6mr4753433wra;
        Tue, 23 May 2006 01:13:10 -0700 (PDT)
Received: by 10.54.127.17 with HTTP; Tue, 23 May 2006 01:13:10 -0700 (PDT)
To: "Martin Langhoff" <martin.langhoff@gmail.com>,
	"Junio C Hamano" <junkio@cox.net>,
	"Matthias Urlichs" <smurf@smurf.noris.de>, git@vger.kernel.org
In-Reply-To: <20060523070007.GC6180@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20576>

Jeff,

good stuff -- aiming at exactly the things that had been nagging me.
Some minor notes on top of what junio's mentioned...

> +    die "unable to open $f: $!" unless $! == POSIX::ENOENT;
> +    return undef;

Heh. Is that the return of the living dead?

> +sub update_index (\@\@) {
> +       my $old = shift;
> +       my $new = shift;

Would it not make more sense to just pass them as plain parameters?

> +       print "Committed patch $patchset ($branch $commit_date)\n" if

Given that we have that -- should we remember it and avoid re-reading
the headref from disk? A %seenheads cache would save us 99.9% of the
hassle.

In related news, I've dealt with file reads from the socket being
memorybound. Should merge ok.

cheers,


martin
