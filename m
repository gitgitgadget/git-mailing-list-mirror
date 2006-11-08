X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Add a MIME-Version header to e-mails
Date: Wed, 8 Nov 2006 11:01:03 +0100
Message-ID: <20061108100103.GA18117@diana.vm.bytemark.co.uk>
References: <eile19$p7r$1@sea.gmane.org> <20061106074532.10376.60478.stgit@localhost> <b0943d9e0611070153s2a52f65k6ed4643e60a144b3@mail.gmail.com> <b0943d9e0611071109w584f4f7fv3ba1b7dbd9413717@mail.gmail.com> <20061108084038.GA3164@diana.vm.bytemark.co.uk> <b0943d9e0611080141y3751039v37b0289147237e4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 8 Nov 2006 10:01:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <b0943d9e0611080141y3751039v37b0289147237e4f@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31132>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhkF6-0001KW-7t for gcvg-git@gmane.org; Wed, 08 Nov
 2006 11:01:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754503AbWKHKBH convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006 05:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754502AbWKHKBH
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 05:01:07 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:5637 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1754503AbWKHKBF
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 05:01:05 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1GhkEx-0004ke-00; Wed, 08 Nov 2006 10:01:03 +0000
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

On 2006-11-08 09:41:33 +0000, Catalin Marinas wrote:

> On 08/11/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > On 2006-11-07 19:09:06 +0000, Catalin Marinas wrote:
> >
> > > I re-implemented parts of the mail and import commands
> > > (inspiring from your patches). They now use the email Python
> > > package. The mail command encodes the body to 7 or 8bit
> > > depending on non-ascii characters.
> >
> > Even though it turned out to be possible to use 8bit always?
>
> I just let the Python email package to the encoding and it first
> tries pure ascii and switches to 8bit if this fails.

Ah, OK, I misread you. This is precisely what I wanted.

> It can also do QP or base64 encodings (if someone complains of an
> old SMTP server, maybe I'll add a config option to force QP body).

Yes, but let's hope we don't have to. :-) And if we do have to, we
should probably autodetect it from the SMTP dialog as Linus explained
(or rather, we should hope that the library can do this for us).

> > > I still have to write a test script but my simple tests showed
> > > that it works. Please let me know if there is anything wrong
> > > (especially with the QP-encoding of the mail headers).
> >
> > I won't have time to check this out today (in fact, it may have to
> > wait until the weekend). But when I do check it out, I might have
> > time to write that test, so please holler if you start working on
> > that.
>
> It would be great if you can run a test script. I've been thinking
> more of an "import" test that also checks both the "export" and "mail=
"
> commands.

I was thinking along these lines too; first make sure the importer
works, by feeding it a number of hard-coded patches in different
formats, and then make sure that the importer can read what the
exporter produces. (With "exporter" meaning both "stg export" and "stg
mail".)

I didn't originally plan to thest the actual e-mail sending, but now
that I think of it, a simple script listening on a random port,
pretending to be an SMTP daemon, should be quite simple to set up.

> BTW, I'll try to add support for mbox importing which is pretty easy
> with the email package.

Sounds good. If you do it in time, I'll write a test for that too. ;-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
