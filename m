From: Leila <muhtasib@gmail.com>
Subject: Re: [PATCH/RFC] revision: Show friendlier message.
Date: Mon, 25 Jun 2012 23:46:16 -0400
Message-ID: <CAA3EhHJfRY=UpuriqB-ARdui3BS6tCpn+Zoi_ccJ15181qGMaw@mail.gmail.com>
References: <1340478681-58476-1-git-send-email-muhtasib@gmail.com>
 <7vobo8hsee.fsf@alter.siamese.dyndns.org> <CAA3EhHJbKj+nbVsZtijsH+h7sFcyeBwT9K=BTeqAuMzSH0RGmg@mail.gmail.com>
 <7vr4t3f9y6.fsf@alter.siamese.dyndns.org> <CAA3EhHLy+5Vfw0T=7VEBi+2ZxjS4x2dndox+M_E06v3FtoNQXg@mail.gmail.com>
 <7vsjdjdm7v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 05:47:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjMkq-000696-9y
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 05:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634Ab2FZDqz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jun 2012 23:46:55 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:57738 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865Ab2FZDqh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2012 23:46:37 -0400
Received: by vcbf11 with SMTP id f11so2391835vcb.19
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 20:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=iq70jRsU5ugIOwC9G/tJGDl4iw6hVfNbl2q+FnqMl1I=;
        b=KCPAFo8PkDEyNXWEjJPoQw0yAaU6KUwNh/F/JLq0kValJwMcf2Ef2ltUM49RieeCU+
         dDlGjG20F6Vt+AnHIcmWGPNmTKtMGgKuUjhDPLDEBTtHOoqxGR4XfJe85RzhggRYXAzg
         eU0tYL9pi4Xm7oz7UoczW5CpgOnPRjhxiHvWRdfCe1b90vrV9/sXrI5W8OgUNoYiLmkI
         czrbZakHm4C0dJ26rrskuyFimrc6nk6g9QHvWA1boaHMK5YkMs02Wv8Wy963kSNgx0OJ
         8Gonc0GcjxQXV+O9wyox3lJ+btuZsqAdFZIxEKVWmDfV9siMct20fpFUtW+vS10tspEC
         g4ew==
Received: by 10.52.97.230 with SMTP id ed6mr8003371vdb.65.1340682396407; Mon,
 25 Jun 2012 20:46:36 -0700 (PDT)
Received: by 10.52.37.233 with HTTP; Mon, 25 Jun 2012 20:46:16 -0700 (PDT)
In-Reply-To: <7vsjdjdm7v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200624>

On Mon, Jun 25, 2012 at 7:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> The "bad HEAD and no revs..." part, if we choose not to even error
>>> on this, can be removed.
>>
>> Yea, I think we should return successfully, and warning() does that.
>> But if we choose to display a message, I don't think it should be a
>> warning (esp for the empty repo case). It should look like the sample
>> printf below, but the v2 of the patch I submitted doesn't include the
>> message.
>
> I said "*if* we choose not to" for a reason.  It can be argued that
> it technically is a regression that "git log" does *not* error out
> for an unborn history, as that is different from the way the command
> has behaved forever.
>

Yes, this is def a concern. Ok here are my thoughts on the four options:
1) Display error message and error. (current behavior)
I don't agree with this, thus the patch I'm creating.
2) Display a friendlier message and error.
I think this is a good option, and preserving the return code will be
less likely to break things (this idea was present in my first patch).
3) Display success message and succeed.
This makes sense to me, but this would be changing the behavior drastically.
4) Succeed silently
I created my second patch to follow this model. I eventually chose
this over 3, because I figured it was more in-tune with the rest of
git's behavior with succeeding silently.

So how do we break the tie between #2 and #4? I think #2 is playing it
safer than #4, even though #4 is more ideal.

> Again, "might want" was a key phrase.  I didn't look at each and
> every one of them and thought if it made sense to change their
> behaviour.
>

Yes, I understood that. I believe I left one out.
