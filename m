From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: RFD: fast-import is picky with author names (and maybe it should
 - but how much so?)
Date: Sat, 10 Nov 2012 19:43:18 +0100
Message-ID: <CAMP44s219Zi2NPt2vA+6Od_sVstFK85OXZK-9K1OCFpVh220+A@mail.gmail.com>
References: <5093DC0C.5000603@drmicha.warpmail.net>
	<20121108200919.GP15560@sigill.intra.peff.net>
	<509CCCBC.8010102@drmicha.warpmail.net>
	<CAMP44s3Lhxzcj93=e8TXwqAVvGJBKhZEVX33G8Q=n2+8+UfCww@mail.gmail.com>
	<509E8EB2.7040509@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Nov 10 19:43:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXG1l-0008IB-Bv
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 19:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438Ab2KJSnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 13:43:20 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53609 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218Ab2KJSnT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 13:43:19 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so5072303obb.19
        for <git@vger.kernel.org>; Sat, 10 Nov 2012 10:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YXZa9gjE09h32auOkYk00IfxZUa2JWMcd4Lyrf+73ck=;
        b=E383qbQJm0VgqiF+8BfBXsJnwMWLV/wKMd/DSIwbX3Woo7NsgePtHVhG68FSRSnfjx
         kZK2z89tFz80O9EI494QJuerW57MrrfM8RH6m9f2lrxf4e0czXLdQwTGbUfvXzHZ0CBt
         lMISW8ikFqKlfDCN6LvGUQLaMb6CFloXuZHXIfGhCLS83rHGuuUspLsxnIL8nbh1y/Ty
         4wFna/94mdQ83PkcUNvtu21og3dUvQ5ufSm+dZAhrDXYNg+pU0cD3KZs3V3LsgGRhIlR
         H8VlRpwjE1wJ4+Anl1RwPEi6agC2LEvmhGx9NyPLrt0XrGtxmwNsoQOo6jUOMCPZHKs/
         1Gdg==
Received: by 10.60.20.1 with SMTP id j1mr1892537oee.46.1352572998882; Sat, 10
 Nov 2012 10:43:18 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sat, 10 Nov 2012 10:43:18 -0800 (PST)
In-Reply-To: <509E8EB2.7040509@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209290>

On Sat, Nov 10, 2012 at 6:28 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Felipe Contreras venit, vidit, dixit 09.11.2012 15:34:
>> On Fri, Nov 9, 2012 at 10:28 AM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>
>>> Hg seems to store just anything in the author field ("committer"). The
>>> various interfaces that are floating around do some behind-the-back
>>> conversion to git format. The more conversions they do, the better they
>>> seem to work (no erroring out) but I'm wondering whether it's really a
>>> good thing, or whether we should encourage a more diligent approach
>>> which requires a user to map non-conforming author names wilfully.
>>
>> So you propose that when somebody does 'git clone hg::hg hg-git' the
>> thing should fail. I hope you don't think it's too unbecoming for me
>> to say that I disagree.
>
> There is no need to disagree with a proposal I haven't made. I would
> disagree with the proposal that I haven't made, too.

All right, we shouldn't encourage a more diligent approach which
requires a user to map author names then.

>> IMO it should be git fast-import the one that converts these bad
>> authors, not every single tool out there. Maybe throw a warning, but
>> that's all. Or maybe generate a list of bad authors ready to be filled
>> out. That way when a project is doing a real conversion, say, when
>> moving to git, they can run the conversion once and see which authors
>> are bad and not multiple times, each try taking longer than the next.
>
> As Jeff pointed out, git-fast-import expects output conforming to a
> certain standard, and that's not going to change. import is agnostic to
> where its import stream is coming from. Only the producer of that stream
> can have additional information about the provenience of the stream's
> data which may aid (possibly together with user input or choices) in
> transforming that into something conforming.

We already know where the import of those streams come from:
mercurial, bazaar, etc. There's absolutely nothing the tools exporting
data from those repositories can do, except try to convert all kind of
weird names--and many tools do it poorly.

So, the options are:

a) Leave the name conversion to the export tools, and when they miss
some weird corner case, like 'Author <email', let the user face the
consequences, perhaps after an hour of the process.

We know there are sources of data that don't have git-formatted author
names, so we know every tool out there must do this checking.

In addition to that, let the export tool decide what to do when one of
these bad names appear, which in many cases probably means do nothing,
so the user would not even see that such a bad name was there, which
might not be what they want.

b) Do the name conversion in fast-import itself, perhaps optionally,
so if a tool missed some weird corner case, the user does not have to
face the consequences.

The tool writers don't have to worry about this, so we would not have
tools out there doing a half-assed job of this.

And what happens when such bad names end up being consistent: warning,
a scaffold mapping of bad names, etc.


One is bad for the users, and the tools writers, only disadvantages,
the other is good for the users and the tools writers, only
advantages.

-- 
Felipe Contreras
