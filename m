From: "Ben Lynn" <benlynn@gmail.com>
Subject: Re: git bugs
Date: Tue, 10 Jun 2008 19:04:33 -0700
Message-ID: <832adb090806101904k5eba3bd6p277c955b1782afbe@mail.gmail.com>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>
	 <alpine.LFD.1.10.0806101028040.3101@woody.linux-foundation.org>
	 <832adb090806101145w55729676ya7bcfb41b0413f59@mail.gmail.com>
	 <alpine.LFD.1.10.0806101249580.3101@woody.linux-foundation.org>
	 <832adb090806101609q17a21948nb5814c3b22bd832d@mail.gmail.com>
	 <7v1w34dfn3.fsf@gitster.siamese.dyndns.org>
	 <832adb090806101702l79aba80cvba1eaab029e9ecd5@mail.gmail.com>
	 <alpine.LFD.1.10.0806101834460.3101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Daniel Barkalow" <barkalow@iabervon.org>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 04:05:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6FiN-0007ja-PE
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 04:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755254AbYFKCEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 22:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755235AbYFKCEg
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 22:04:36 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:8699 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620AbYFKCEf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 22:04:35 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1969013fgg.17
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 19:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ekPgZc+SE8giYv2oS+1x124D4SGt08MiiQpUZG+eeZg=;
        b=qJhiGtQZCFoGJewlcoD6TCu3rFnNLkCbE/MkXdDhpmfJi4RcUdvG8EXs0qcFgIcyC7
         CecfrFNdOYvNJ2mYNT/Msvtur0OfU3fWLo6SYKAynJ06Vt1nzIX2eCDcgrP+AdqWWKYh
         uWOET64zX7rs7vvNGCaOH3G2KW+7Qz+AJIiyI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=bBjBVFwShKwfLjgEuXeHsBajGj49LD0jowZDIaWvH1IFBfEjGaQFkgMMbeuC/nAGvw
         5TZEtNuzCL4YmF/1bU2jlLZpOBSmwZpxZOSgDbHhO9zlTlpyzt4xTtQ2e2GiVcC1TjoN
         ua0hNfZm5FveYjINsPm+IXV/DqQkXIOO1HC74=
Received: by 10.86.66.19 with SMTP id o19mr6459057fga.62.1213149873267;
        Tue, 10 Jun 2008 19:04:33 -0700 (PDT)
Received: by 10.86.79.17 with HTTP; Tue, 10 Jun 2008 19:04:33 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0806101834460.3101@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84579>

> The right way to do things would be to just do a stat() on the index file
> as it is created, and then save the mtime of that stat into the file. That
> way, you have the mtime of the index file not for the *last* write, but
> for the *first* one.

Sorry, but if we're assuming no one is touching the files while we're
updating the index (including writing it to disk), why does it matter
whether we use the time of first or last write? In fact, if a index
write takes a long time, using the last write time as the mtime would
be beneficial for the race condition stuff.

-Ben
