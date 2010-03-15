From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Dealing with an upstream cherry-picked branch
Date: Mon, 15 Mar 2010 19:39:41 -0400
Message-ID: <32541b131003151639o173669a7v4b3b4c13bc7e153@mail.gmail.com>
References: <76718491003142117w4fd10449j51deef27548c4d2e@mail.gmail.com> 
	<32541b131003151146qeb6b15bqa9317c6d56443e8e@mail.gmail.com> 
	<76718491003151407p3cdecf8fx1ddebf19ce304f83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 00:40:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrJtJ-0002YG-0s
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 00:40:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937171Ab0COXkE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 19:40:04 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:39207 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933017Ab0COXkC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 19:40:02 -0400
Received: by gxk9 with SMTP id 9so2177238gxk.8
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 16:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=fl1F82bTZCvhXl9w7UNwyzxMqZ6hA17oEdt5f5O/y4c=;
        b=G37Cij+mwuZFgBa9qUNdKqaXOmstt/ZxtEjOzKZNReQN82I10oZzQM6A7ZEdMlkDZA
         M+kLVLFV2hqOU/MuRWw1zfJuT6/+OpwU/1jOsfm/LvUi37dfPbDK/xY4VwH8tA92hlT7
         fchvUMv/7Egmz07NVHID6O5m5ZK+k4aV3Ravk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=cnMj+P2SCoIKxbVxC2M4S6xA9C7HFwNlT4768KYD4pNUlWkpye9q+hxYGtxpVimMTi
         CWmGWjvt+RxxnF8G1NaYLaUWFXS2W1ILMAfVyiA1lYSQyKK/4LVkueRTwAySRaPgB+WP
         2/ZYViHrqvEl5WGORI4q/0c19blHnmU6zfS7Q=
Received: by 10.150.168.37 with SMTP id q37mr1143074ybe.265.1268696401073; 
	Mon, 15 Mar 2010 16:40:01 -0700 (PDT)
In-Reply-To: <76718491003151407p3cdecf8fx1ddebf19ce304f83@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142280>

On Mon, Mar 15, 2010 at 4:07 PM, Jay Soffian <jaysoffian@gmail.com> wro=
te:
> On Mon, Mar 15, 2010 at 2:46 PM, Avery Pennarun <apenwarr@gmail.com> =
wrote:
>>> Jay Soffian wrote:
>>> (c) Create a new branch at point Ma and cherry-pick only the local
>>> commits from local-master past point Ma. This essentially gives me =
the
>>> clean local-master I would've had if I'd been doing (1) all along.
>>
>> This will work, but the short form for exactly the same operation is=
:
>>
>> =A0 =A0 =A0 =A0git checkout -b local-b local-master
>> =A0 =A0 =A0 =A0git rebase --onto upstream-master upstream-a
>
> Are you sure that will skip the merges into local-master from
> upstream-a? I didn't think so and it's not my recollection based on
> using --onto previously.

It should.  The --onto option is rather confusing to get right, and
because git is pretty smart, sometimes the rebase will end up doing
what you want (maybe with some extra conflicts) *despite* using the
wrong (or no) --onto option.

Basically, the 'upstream-a' option above means "remove everything
that's in upstream-a" and then the --onto option means "and then paste
what's left on top of upstream-master".  Since your merge commits only
add things from upstream-a, they too should be left out of the rebase.

Sometimes I find this gets confusing.  You can often sort it out by
using 'rebase -i' (with otherwise the same options as above) and
tweaking it a little.  But the upstream-a commits should definitely
all be gone.

Have fun,

Avery
