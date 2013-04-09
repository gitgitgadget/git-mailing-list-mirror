From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Tue, 9 Apr 2013 23:09:20 +0530
Message-ID: <CALkWK0=siuUW1ex0muy+efwQOAwHf3uorFHWPo5sjMss08ywiw@mail.gmail.com>
References: <CALkWK0nYECHZaxit9jR-tS=7fXyOP5dy6mqUz0DKmbTRU-xRNw@mail.gmail.com>
 <20130318170804.GA15924@sigill.intra.peff.net> <CALkWK0k2a6DSUodhKjRFKGvE1Rb_QmFgpy=Pvbu2Q=nGNYuByA@mail.gmail.com>
 <7vzjx7sj9u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 19:40:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPcWh-000819-Id
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 19:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765085Ab3DIRkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 13:40:03 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:38574 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760602Ab3DIRkB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 13:40:01 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so8867557iec.33
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 10:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=/DLLDl9kIs4Bv+3hDp0WgslgW37Je+UzivCJEMSso/4=;
        b=qZclAn5uNeq8jNanYwX/s6NCHvlrV2qYG3PEEuVUB5kwvH8H5n7s98TxlAPvSA5vwR
         KfFmVzne7Lp4+cXUo3tlNE6aOR/TbupKeU/NiyaUXpoUZQ2EOFgKHSmHA3BaWQcxWrtQ
         A/GOAgV+sPftbh8TWiKzIYtL/yqMONK6QY8g7kXVlT8xlF1K9OYEaCk1rLITx1mswyBr
         sh/5BOpdwD77NY6hZUTEfFsYj6Qv7UdLmFrtFsffvrKQvWJAOinqIvn6CLutN1DtqwYI
         eWc6MFaG47546gaIl0qppj4ZF6lRh/30QstciLsuUJDjn9O4p2DHq0uRefWumPTm7bI1
         sLhA==
X-Received: by 10.50.119.102 with SMTP id kt6mr11189780igb.12.1365529200828;
 Tue, 09 Apr 2013 10:40:00 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Tue, 9 Apr 2013 10:39:20 -0700 (PDT)
In-Reply-To: <7vzjx7sj9u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220595>

Junio C Hamano wrote:
> host:foo/bar (take my "host" branch, push it to their "foo/bar"
> branch) could be tricky, no?  It could be trying to go over the ssh
> to "host" and access repository at $HOME/foo/bar.  The git_connect()
> call may even succeed and you cannot use the failure as a hint to
> disambiguate.
>
> Also the request may genuinely be to access foo/bar repository at
> the host, but the network layer had trouble connecting temporarily
> to the host.  After disambiguating incorrectly to push to the
> origin, mapping our host branch to their foo/bar branch, that push
> might even succeed.

Oh, ouch.  I didn't think of that.  What do you suggest we do?  Go
with Duy's simple '-' solution, or try some heuristics that may lead
to confusing behavior in edge cases?
