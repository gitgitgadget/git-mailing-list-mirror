From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 4/4] remote: new show output style
Date: Thu, 19 Feb 2009 12:57:32 -0500
Message-ID: <76718490902190957td40d425p6b2ae1242060114d@mail.gmail.com>
References: <1235020471-59982-1-git-send-email-jaysoffian@gmail.com>
	 <1235020471-59982-2-git-send-email-jaysoffian@gmail.com>
	 <1235020471-59982-3-git-send-email-jaysoffian@gmail.com>
	 <1235020471-59982-4-git-send-email-jaysoffian@gmail.com>
	 <1235020471-59982-5-git-send-email-jaysoffian@gmail.com>
	 <499D82BC.7020500@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 18:59:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaDAt-0003pu-7L
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 18:59:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109AbZBSR5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 12:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753066AbZBSR5e
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 12:57:34 -0500
Received: from rv-out-0506.google.com ([209.85.198.226]:64447 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbZBSR5d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 12:57:33 -0500
Received: by rv-out-0506.google.com with SMTP id g37so515479rvb.1
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 09:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kAXGtWbDXxwGV4wm8t41IJTRF2RmjN1NvEO08UgCk8Q=;
        b=ONDasN8vdt3SqqXz0ySu7yatLI/8dMKeRVRlgBQMU7mOQIDtHUG6AcN8y8n6pKeVbB
         dhRzv6xcm/r5lUDVBRhrd1pGh+1jrWatdx42p6UtrgoCx5dlNnBEVAfMUxrdmKPBRiDr
         OGE89zA190NRyoCdq2QBlycEAsWLlf+U3adq4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BC3VRNAVgG7E/8cTMWU36ffg+zH6WPw0zm7HVkk2+3hBuvq+ZwpHDET6XDl2MfN/u7
         WH/byU0E5Sh4ogNUor0Z27WgEMjsQs45HyFTGKjkJSi1nU9kHvtmGpIfznpy6iZfk1ng
         1bfOxGPiTpAmdWCYtBxgvvrUEHRAA6ZvK6JLY=
Received: by 10.140.140.3 with SMTP id n3mr4736057rvd.111.1235066252557; Thu, 
	19 Feb 2009 09:57:32 -0800 (PST)
In-Reply-To: <499D82BC.7020500@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110723>

On Thu, Feb 19, 2009 at 11:03 AM, Marc Branchaud <marcnarc@xiplink.com> wrote:
> First, a nit: I don't know if the "w/remote" notation makes sense to
> non-English speakers.  I also like the alignment achieved by "merges with
> remote " (note the trailing space).

I tried out a few different option and none was very satisfactory to me.

1)
    master            rebases onto remote master
    another-branch    merges with remote  next
    some-other-branch rebases onto remote master

Here, the unaligned "with" and "onto" is ugly.

2)

    master            rebases onto remote master
    another-branch    merges  with remote next
    some-other-branch rebases onto remote master

This looks better to me. However, if none of your branches rebase,
then the extra space looks like it is a mistake. e.g.:

    master            merges  with remote master
    another-branch    merges  with remote next
    some-other-branch merges  with remote master

I could add code to detect whether all the branches merge and then not
output the space, but, sigh. And I couldn't think of any other
combination of words that had the same character spacing.

So that's how I ended up with "merges w/remote". This is also slightly
less wide. I always try to have output fit into 80 columns (how
quaint, I know) and a merging branch might have multiple upstreams.
e.g.

   another-branch merges w/foo, bar, baz

IOW, the output in the patch wasn't arbitrary. I did think about it
quite a bit. Which isn't to say it's right, just it's the best I came
up with.

I'm somewhat confused by "w/remote" making sense to non-English
speakers as it's English output.

> Second, I think it would be good to also change the format of the 'git push'
> list, for consistency:

I left that out on purpose. The only folks with push refspecs put them
their manually, and the raw refspec is clearer and more concise than
any English words can convey. That was my reasoning anyway.

Thanks for the feedback.

j.
