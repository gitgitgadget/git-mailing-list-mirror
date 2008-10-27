From: "Benoit Boissinot" <bboissin@gmail.com>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Mon, 27 Oct 2008 10:29:36 +0100
Message-ID: <40f323d00810270229w7dfecabcm86e5e611fb4250ef@mail.gmail.com>
References: <ge0rla$mce$1@ger.gmane.org> <200810261955.10536.jnareb@gmail.com>
	 <200810270147.52490.arne_bab@web.de>
	 <200810270252.23392.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Arne Babenhauserheide" <arne_bab@web.de>, SLONIK.AZ@gmail.com,
	mercurial@selenic.com, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 10:31:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuOR1-0004YD-2L
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 10:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbYJ0J3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 05:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752397AbYJ0J3k
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 05:29:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:19119 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbYJ0J3j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 05:29:39 -0400
Received: by nf-out-0910.google.com with SMTP id d3so624153nfc.21
        for <git@vger.kernel.org>; Mon, 27 Oct 2008 02:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Sg20dBe14u767HfL5l0FBs2Gc+KbUOkumn1Zb1drioQ=;
        b=XfbBJjW+IrjvECXoUenKvMpD6dgHr/MjjM0pxw9Mt3sB5tu3pT6N96WSfOmbzFHSmq
         o2BsvbBG5p/eiMt0R+EtRTJ2nJD+mX8JZxYovcqyBKYLHHS+8EV+ZfJXSXSJ0UVVQM9V
         jR7XUlczIkCX7blArwf/950aRVUfot89qANvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ivlINWamphdsLk4F/yBRq4GE91myN7uEuRcX9WQ68XFubhbsHQbNpmjYFqbUwqflO3
         dgj413x3/sE8oyRO4jEorAoxmiGvVFmH/dPcDYW84b66nqRIAYpLWC4zTHiniq/GVv3Q
         18dymNdTFtpjMwvOHyN9EwatnRYYeUXo3KpfA=
Received: by 10.210.16.17 with SMTP id 17mr6364117ebp.146.1225099776139;
        Mon, 27 Oct 2008 02:29:36 -0700 (PDT)
Received: by 10.210.69.9 with HTTP; Mon, 27 Oct 2008 02:29:36 -0700 (PDT)
In-Reply-To: <200810270252.23392.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99218>

On Mon, Oct 27, 2008 at 2:52 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Mon, 27 Oct 2008, Arne Babenhauserheide wrote:
>> Am Sonntag 26 Oktober 2008 19:55:09 schrieb Jakub Narebski:
>> >
>> > I agree, and I think it is at least partially because of Git having
>> > cleaner design, even if you have to understand more terms at first.
>>
>> What do you mean by "cleaner design"?
>
> Clean _underlying_ design. Git has very nice underlying model of graph
> (DAG) of commits (revisions), and branches and tags as pointers to this
> graph.

Git and Mercurial are very close from that point of view.
Mercurial explicitely disallow octopus merges (and we don't think there's
a good reason to allow them, although I agree with Linus, they look very nice
in gitk ;) ).
And we don't have "branches as pointer" in core, but the bookmark extension does
that.
Appart from that I think the underlying format are interchangeable, someone
could use the git format with the hg ui, or use revlogs (the basic
format of mercurial)
like packs.

The only special thing about revlogs is the linkrev stuff, it's a
pointer to the first revision
that introduced an object, so we can easily find what to send in our
network protocol
(we don't have to read the manifest, ie the "tree" of objects").
linkrev can be useful
to speedup "hg log" too.

> I have read description of Mercurial's repository format, and it is not
> very clear in my opinion. File changesets, bound using manifest, bound
> using changerev / changelog.
>

just do a s/// with the git terminology:
filelog -> blob
manifest -> tree
changelog -> commit object

regards,

Benoit
