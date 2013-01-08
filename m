From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] clone: forbid --bare --separate-git-dir <dir>
Date: Wed, 9 Jan 2013 06:34:21 +0700
Message-ID: <CACsJy8B=h04QAeb0D-PWvT=0n_+QfW27NuUg3KEFUN3C4MOJVQ@mail.gmail.com>
References: <20130106091642.GA10956@elie.Belkin> <1357465670-32766-1-git-send-email-pclouds@gmail.com>
 <20130106101948.GD10956@elie.Belkin> <20130108141650.GA18637@lanh>
 <50EC543D.5090100@web.de> <7v4nirfu1p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	"W. Trevor King" <wking@drexel.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 00:35:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsihN-0005yq-4O
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 00:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755013Ab3AHXex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 18:34:53 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45050 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481Ab3AHXew (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 18:34:52 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so1540631obb.33
        for <git@vger.kernel.org>; Tue, 08 Jan 2013 15:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QlhILZgP2Nlol/L4Dybv49hJuI4KTzTzMekI95xFIME=;
        b=tpb0501vYXZ/05TXVE2FCfpK9Mo5UEL80LZSMi1/+lBkzcIegc6XjV9gab9gyFyatH
         gu+4+KmF9bEKT+Hz2Ljnx7oznih8phQKvkY3WsFdgHj3bXKHlSIpXluLjL0Gb5rn5DBD
         mOJnEqBWAEbTqtkcrloOtAYyfBvrBnf3OA8L0QlujssZkQRcpXfiagSfN7/pe3m9OIn2
         suLmEMw9KjzTbX7eIwydPOgOYBdQNv1XyyfeVUGtR9AfznIBypfN5F+I50Ht8x2FAvkL
         S7YTBRZYn92IS2dQoI6cxttZ9LdBc/hPvi8bZV4/7iqrZE7K4ljBU5aRzCAgrnnXuCfW
         Dzug==
Received: by 10.182.164.103 with SMTP id yp7mr46447524obb.74.1357688091954;
 Tue, 08 Jan 2013 15:34:51 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Tue, 8 Jan 2013 15:34:21 -0800 (PST)
In-Reply-To: <7v4nirfu1p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213015>

On Wed, Jan 9, 2013 at 12:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>
>> Am 08.01.2013 15:16, schrieb Duy Nguyen:
>>> On Sun, Jan 06, 2013 at 02:19:48AM -0800, Jonathan Nieder wrote:
>>>>     Unfortunately we forgot to forbid the --bare
>>>>     --separate-git-dir combination.  In practice, we know no one
>>>>     could be using --bare with --separate-git-dir because it is
>>>>     broken in the following way: <explanation here>.  So it is
>>>>     safe to make good on our mistake and forbid the combination,
>>>>     making the command easier to explain.
>>>>
>>>> I don't know what would go in the <explanation here> blank above,
>>>> though.  Is it possible that some people are relying on this option
>>>> combination?
>>>
>>> I can't say it's broken in what way. Maybe it's easier to just support
>>> this case, it's not much work anyway. Jens, maybe squash this to your
>>> original patch?
>>
>> I'd be fine with that, though my gut feeling is that this should
>> be a patch of its own (My patch handles the git dir, your's handles
>> a work tree issue).
>
> I agree that these are totally unrelated issues.
>
> After all, Jonathan's suggestion to forbid it was because the
> combination does not make sense and does not have practical uses,
> and forbidding it would make the command easier to explain than
> leaving it accepted from the command line.  If you choose to go in
> the opposite direction and make "clone --bare --separate-git-dir" do
> something useful, it should be explained very well in the
> documentation part of the patch why such a combination is a good
> idea, and in what situation the behaviour is useful and the user may
> want to consider using it, I think.

It is more like postponing the usefulness evaluation of the
combination until later (maybe someone will come up with an actual use
case). As of now, --separate-git-dir --bare is a valid combination.
Jens' patch fixes one case but leave the other case broken, which is
why I think it should be in one patch. It's rather ducking head in the
sand than actually declaring that the combination is useful.
-- 
Duy
