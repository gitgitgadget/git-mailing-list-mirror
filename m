From: Bryan Turner <bturner@atlassian.com>
Subject: Re: http-protocol question
Date: Tue, 2 Dec 2014 16:47:50 +1100
Message-ID: <CAGyf7-FDRS_zGQSFKhV8UGfN5GjGcyo0yCz8bcjEALYF3oj=Bg@mail.gmail.com>
References: <CAGyf7-HmvvHQZkyLgKAs2rrZTTLFkBa8s828hbS9LedLNb2fWA@mail.gmail.com>
	<20141202033416.GY6527@google.com>
	<CAGyf7-GZbRBN4O_yNgrmJCya=6f8XQ4O8m7WBa1k8Ve196ajYQ@mail.gmail.com>
	<20141202044522.GZ6527@google.com>
	<CAGyf7-Gx1VU-1OicCHG0sStUnNXy_0Y8VYUP+PZjpN6nz7dTrw@mail.gmail.com>
	<20141202053331.GA31516@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 06:47:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvgJX-0003yq-2r
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 06:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373AbaLBFrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 00:47:51 -0500
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:54663 "HELO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754319AbaLBFru (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Dec 2014 00:47:50 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]) (using TLSv1) by na3sys009aob118.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVH1ShrkU0rZrYDwCkW4OftdMrHJaIMEY@postini.com; Mon, 01 Dec 2014 21:47:50 PST
Received: by mail-ob0-f176.google.com with SMTP id vb8so9091935obc.35
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 21:47:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=HNsTtDbPzU2ydNvcSsTlmaRGac71xgdTFXKgeJ4FtJ8=;
        b=MArdlayDJqKMkssyXZ3R57TiByxJO3Sk43NlMG6y4EmvKhc0pIgA5olYnxVjay5C00
         pV052KC57LDYSPBd5zMe0NCKBDqZwMx9xllSPrLTjuL+KmfufwLUmfIDZ6uSNbfZny41
         XEDgzNyHxLCjc2fTBAJnrp8UeJQ+aFqfjeexXQYWG9HN7OiF67QbfK8jQwHux3sOAdrv
         89HqVT6ZZBj2v5b6lD7NyvBXt7CvRlQNL+X8FTGhYe5W/7Fxtv5XIlZd8qTU3naQt/oQ
         Pmrh524oV6bZeKHhIjmPMpg3qAF54MMb8GFGR/u6yDUMn64BnXGm1FyRiEhp9XjQJfS7
         2FkQ==
X-Gm-Message-State: ALoCoQmZAy4QsoBEoDOy+p4bSyP6hddGQHnh0Q9nD05J4RQT1JcU6NAVh9B+6NE1W8GvNsq6/RIRXfRo+PF2cfBCvN7C12ySc6qft49VLweUbJibeV4YEzhmxF8G0a1fj52eYA8PXK4qLbloH+53rzrW5cP0iqHFIQ==
X-Received: by 10.60.55.200 with SMTP id u8mr38204616oep.43.1417499270216;
        Mon, 01 Dec 2014 21:47:50 -0800 (PST)
X-Received: by 10.60.55.200 with SMTP id u8mr38204613oep.43.1417499270081;
 Mon, 01 Dec 2014 21:47:50 -0800 (PST)
Received: by 10.182.245.170 with HTTP; Mon, 1 Dec 2014 21:47:50 -0800 (PST)
In-Reply-To: <20141202053331.GA31516@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260539>

On Tue, Dec 2, 2014 at 4:33 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Dec 02, 2014 at 04:04:11PM +1100, Bryan Turner wrote:
>
>> > Can you say more about the context?  For example, was this actually
>> > happening, or is this for the sake of understanding the protocol
>> > better?
>>
>> I ask because it's actually happening. Heavy CI load sometimes has
>> builds fail because git clone dies with "not our ref". That's the
>> specific context I'm working to try and address right now. Some teams
>> use rebase-heavy workflows, which also evades the check_non_tip easing
>> and fails with "not our ref", so I can't be 100% certain it's ref
>> deletion in specific causing it (but I guess which of those it is is
>> probably largely academic; as long as hosting spans multiple requests
>> it seems like this type of race condition is unavoidable).
>
> There is a practical reason to care. Ref deletion will also delete the
> reflog, leaving no trace of the reachability. Whereas a non-fast-forward
> push could be resolved by looking in the reflog.

A fair point. I had mistakenly thought that reflogs would survive the
ref's deletion and be "pruned" as part of garbage collection, but a
quick test shows that, as I'm sure you already know, that's not true.

Thanks for correcting my mistake!
Bryan Turner
