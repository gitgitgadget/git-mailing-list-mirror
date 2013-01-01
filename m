From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC] pack-objects: compression level for non-blobs
Date: Tue, 1 Jan 2013 19:10:54 +0700
Message-ID: <CACsJy8DpnO6X6jdQVsr1NwrXF2MDBBcHZQTay=TyLFc5p_z9eg@mail.gmail.com>
References: <1353911154-23495-1-git-send-email-b@rr-dav.id.au>
 <20121229004104.GA24828@sigill.intra.peff.net> <CACsJy8D_E0shqJAvZH7xqij6F4a6qUxkUPNcZL=0yX5w9bLd_g@mail.gmail.com>
 <20121229050707.GA14475@sigill.intra.peff.net> <CACsJy8AN3y_4wcZ_w0zz+ZAaDasRT-+h8vA_fp2j4+FL00dbLw@mail.gmail.com>
 <20121229052747.GA14928@sigill.intra.peff.net> <20121230120542.GA10820@sigill.intra.peff.net>
 <CACsJy8C4UttGKcw11do1POcHZJM7iZ2r7F3ESOqEnWL8kdz+dQ@mail.gmail.com>
 <20121230213124.GA15946@sigill.intra.peff.net> <CAJo=hJtjtpiPVd6Koy9q5je7s7A4EyDa-CptJNCnHLSLgd9W7g@mail.gmail.com>
 <CACsJy8CygfaM+Ee6rURFB-cP2khO8URGDJMG2f3mqg0ebYz+8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>,
	David Michael Barr <b@rr-dav.id.au>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 01 13:11:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq0hG-0000Rz-LX
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 13:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188Ab3AAML1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 07:11:27 -0500
Received: from mail-ob0-f179.google.com ([209.85.214.179]:56164 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150Ab3AAML0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 07:11:26 -0500
Received: by mail-ob0-f179.google.com with SMTP id x4so12007710obh.24
        for <git@vger.kernel.org>; Tue, 01 Jan 2013 04:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lT+n0zzChC5vECuxzFDrF/P3gHobuvGI9a93p/PBiIg=;
        b=0wF8pSG4XwC3by9WW39M9hdv6/aQQBgwWaCjq6pTMXCEoLDOC4SFg39z7GRy2F+9Go
         lZXBpFKVSTVhB7zRudabx+0RtqFtzlhJgrGrrslV/5ykvBA6de5PgRefahFfWcnviMdw
         G0K/3EZO6Yfs69vxdZ5nX9VScZXvbQkdO9SJazFdOq00GVtI2MMlDmb8sXr2p8+motRn
         1+xZVYyy1gy6raQfw66A91uDzw2J6QALWyhsbBQaiyVkzCHTGX2ADKBiopTW9F835eBC
         /bBwLZ6nT6IMcjR6v64q7Y2QE1zS/2llZtq2kW/fnr80IGeBCpgKK5pQC2vIqWwWZreT
         nMLQ==
Received: by 10.60.12.74 with SMTP id w10mr24717338oeb.100.1357042285830; Tue,
 01 Jan 2013 04:11:25 -0800 (PST)
Received: by 10.182.27.168 with HTTP; Tue, 1 Jan 2013 04:10:54 -0800 (PST)
In-Reply-To: <CACsJy8CygfaM+Ee6rURFB-cP2khO8URGDJMG2f3mqg0ebYz+8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212421>

On Tue, Jan 1, 2013 at 11:15 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> Fix pack-objects to behave the way JGit does, cluster commits first in
>> the pack stream. Now you have a dense space of commits. If I remember
>> right this has a tiny positive improvement for most rev-list
>> operations with very little downside.
>
> I was going to suggest a similar thing. The current state of C Git's
> pack writing is not bad. We mix commits and tags together, but tags

And I was wrong. At least since 1b4bb16 (pack-objects: optimize
"recency order" - 2011-06-30) commits are spread out and can be mixed
with trees too. Grouping them back defeats what Junio did in that
commit, I think.
-- 
Duy
