From: "Ondrej Certik" <ondrej@certik.cz>
Subject: Re: git fast-export | git fast-import doesn't work
Date: Wed, 26 Nov 2008 00:39:44 +0100
Message-ID: <85b5c3130811251539n6cb175b4p185d37385bf43d1e@mail.gmail.com>
References: <85b5c3130811250844u498fbb97m9d1aef6e1397b8c7@mail.gmail.com>
	 <492C367D.3030209@drmicha.warpmail.net>
	 <20081125204108.GF4746@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Michael J Gruber" <git@drmicha.warpmail.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Fabian Seoane" <fabian@fseoane.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Nov 26 00:41:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L57Wn-0001oV-9Q
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 00:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbYKYXjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 18:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbYKYXjr
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 18:39:47 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:63103 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbYKYXjr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 18:39:47 -0500
Received: by nf-out-0910.google.com with SMTP id d3so111701nfc.21
        for <git@vger.kernel.org>; Tue, 25 Nov 2008 15:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=/vt1O5sSNHVOupiLt6Q+4GEPhWCmcN4/9LZseUM9LfI=;
        b=GiobEpWPZ32mdx2J4NNS/+shCH6MgW2X3smmUktZat8Y38AFSq3S3BmcB/ZL/p+e7X
         ue7XCurvBmbT53QfODL/nUd307+bJB7uVsfq5QcokFpXBiBDgu+XJ/7SUQtmjvmi+f2O
         kOIqEAX1yZ8LObUvlH6luy9mzAQKKywkDaiXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=D7S/2QMPrvcDqKOBDKp49mD1kVu1CjrNsa9x7kHkk93yM+jwVbt6qC9V7DZR6TCqGq
         kNepJ42SqiBxOv0LGygy2sGTGZdWPQ2AP51Y9XPcot7LgoWKEFe+9aDWtyOi4xvrYfKK
         uMOO3vsmQTtyfS+LIuXt+tZNYmqwk/NqO4wfk=
Received: by 10.86.57.9 with SMTP id f9mr3325402fga.32.1227656384187;
        Tue, 25 Nov 2008 15:39:44 -0800 (PST)
Received: by 10.86.33.8 with HTTP; Tue, 25 Nov 2008 15:39:44 -0800 (PST)
In-Reply-To: <20081125204108.GF4746@genesis.frugalware.org>
Content-Disposition: inline
X-Google-Sender-Auth: b4102b618e6ac6aa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101693>

On Tue, Nov 25, 2008 at 9:41 PM, Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Tue, Nov 25, 2008 at 06:31:41PM +0100, Michael J Gruber <git@drmicha.warpmail.net> wrote:
>> I don't know, I just noticed that turning on rename and copy detection
>> makes git-fast-import crash, which shouldn't happen either. Something's
>> not right here. CC'ing the authors of im- and export.
>
> Could you please write a testcase that reproduces your problem?
>
>> Why export|import directly to git?
>
> I guess he did not know about filter-branch. :)

I know about filter-branch (but I am not sure it can do what I want).
I made a mistake of not explaining what I want, instead I suggested (a
possibly wrong) solution. I want to export the whole git repository as
a set of human readable patches, that can be assembled back into a git
repository (with the same hashes as the original one) if needed. The
reason I want that is that if we later decide to switch to another
VCS, we have all the information to reproduce the repository. Another
reason is to be sure that we know all the sources that are needed to
construct the repository, e.g. that there are no binary blobs
(possibly containing malicious code). Another reason I want that is to
be able to rewrite the history, in particular, we have one Mercurial
repository with some old history and another Mercurial history with a
newer history and I just want to concatenate them together into one
git repository.

In each case I know several workarounds, but if there is a way to just
convert the whole git repository into a set of patches and (and be
able to convert everything back including the same hashes), then it'd
be awesome.

See also this thread why people want this (and I assumed git can do
this from this thread):

http://groups.google.com/group/sage-devel/browse_thread/thread/7b116d902ee20d9c/

Thanks,
Ondrej
