From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Not a BUG: For first push to a bare repo, using "--tags" prevents creation of master branch
Date: Tue, 02 Jun 2015 16:48:35 -0700
Message-ID: <xmqq6175zn70.fsf_-_@gitster.dls.corp.google.com>
References: <CABRuA+iVRZR9SxvYVCO5zd0hZEbn6tioyP6dZ5xSbaAeNF4w+w@mail.gmail.com>
	<vpqbnh4hro7.fsf@anie.imag.fr>
	<xmqq617bflzh.fsf@gitster.dls.corp.google.com>
	<vpq4mmvs7zx.fsf@anie.imag.fr>
	<xmqqeglze5cu.fsf@gitster.dls.corp.google.com>
	<vpqoal3p8wo.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Darling <darlingm@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 03 01:48:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzvvH-0005DZ-TV
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 01:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbbFBXsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 19:48:39 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:33890 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbbFBXsh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 19:48:37 -0400
Received: by iecwk5 with SMTP id wk5so938689iec.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 16:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=rpeb2hJp0czOAM6yCqVStP3T2VyD9O5dgQiKwjoIR+U=;
        b=ckzlGgYzS1g1EXCuoQUamM3xGaIqruvnCJIjjcWdUSxa2iElvm7gjbwOlHUkSQ/ZXr
         gdErsgXC8UsC6X1obDUtqkMaVc1UmPpMwtk4/loGch0/KKUL1hcB6Vd5kQnpGkLr/WzE
         TLMGyoT3GYdlo/SwoNnZvfb59rQjNl/XdXCoIQEWK+5KnhSAAEesiKgHnpr1reaseWDg
         ksQop2TS6Q53LGc0cPdtUnWUpC2yXGTA37iAV/DJt8Wis7Kr772/52Uy/YqaIJ5XAy62
         IQ80R1Ya944xg+ZfOrjny77L3FUcj/h82rcLMSJE7MxgA/evhaAkFYz0vRc+wWwtLj01
         /0qw==
X-Received: by 10.43.40.130 with SMTP id tq2mr37718124icb.46.1433288917375;
        Tue, 02 Jun 2015 16:48:37 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3140:53f3:e8c0:89b0])
        by mx.google.com with ESMTPSA id rt5sm11036051igb.8.2015.06.02.16.48.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jun 2015 16:48:36 -0700 (PDT)
In-Reply-To: <vpqoal3p8wo.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	29 May 2015 19:53:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270620>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I recall "fetch --tags" was updated to become your "--tags-also" by
>> e66ef7ae (Merge branch 'mh/fetch-tags-in-addition-to-normal-refs',
>> 2013-12-12).  Perhaps we should do the same on the push side.
>
> Would we still have a way to push tags only with this?
>
> fetch and push are a bit different: it's almost never a bad idea to run
> fetch (I see remote-tracking as a kind of cache, and fetch is the way to
> refresh this cache), but pushing too much can be harmful. Not a strong
> objection, but I'm not sure that this change is 100% safe for everyone.

Whether the user is familiar with "git fetch --tags" or not, "git
push --tags" that is not spelled as "git push 'tags/*'" does look
like an option that augments what the command normally does, and the
"mistaken" (non-)bug report was very understandable. 

After having thought about this, I would say that it would not add
much value to the system if we add it as "git push --tags-also".  We
should either keep the current semantics as-is, or we replace "git
push --tags" to make it similar to what "git fetch --tags" does, I
think.
