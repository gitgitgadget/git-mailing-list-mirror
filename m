From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Safe to interrupt =?iso-8859-1?B?u2dp?=
 =?iso-8859-1?Q?t_gc_--auto=AB=3F?=
Date: Wed, 29 Oct 2014 13:50:51 -0700
Message-ID: <20141029205051.GK5500@google.com>
References: <87fve6gbk3.fsf@kepler.schwinge.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Schwinge <thomas@codesourcery.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 21:51:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjaCr-0003e2-6p
	for gcvg-git-2@plane.gmane.org; Wed, 29 Oct 2014 21:51:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755698AbaJ2Uu5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Oct 2014 16:50:57 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:52493 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755548AbaJ2Uu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2014 16:50:56 -0400
Received: by mail-pd0-f170.google.com with SMTP id z10so3681631pdj.15
        for <git@vger.kernel.org>; Wed, 29 Oct 2014 13:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ztvFkSkhnd+eTA2fhS7DPot2LgK6b9hpBUvAY9xz388=;
        b=au5YbrmmstJtdKFut7lv4JymOn4pQJUCdYIXI67uYN2LvEa3T7y3/jxKg3fQT+3gJP
         /OeUG0GBpUsG3fXW1UmvQbQ5jUke1BveqJ7ckdNB1ov69aTXIWQbjych4ApzK7xDCU17
         K1iuHp3At3O6VkxRLSc3eqPoPOydB1sjAYLQlSPFfJPxeUTQUUy7oI263Q63qso/+/Us
         acv+ygRSkmwqeepf3oHk0k2Vajm13jGChlRIjlpAw61DFi+tllpcGQotASxGd3V2VbSV
         qwVijMzStuUoWsEmS/K6P4hUfhWEKCDnVY0fsiDqUKvnsS1jlPTrobTmXTHK9UtdPfuU
         ft1g==
X-Received: by 10.66.222.41 with SMTP id qj9mr12472072pac.21.1414615856289;
        Wed, 29 Oct 2014 13:50:56 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:f533:926:ab59:eb4f])
        by mx.google.com with ESMTPSA id kl3sm5110041pdb.87.2014.10.29.13.50.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 29 Oct 2014 13:50:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87fve6gbk3.fsf@kepler.schwinge.homeip.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Schwinge wrote:

> I couldn't find this answered in the documentation: if, instead of
> exiting right away, a =BBgit gc --auto=AB actually commences its hous=
ekeeping
> tasks, is it safe to interrupt (C-c, SIGINT) the original git invocat=
ion
> at this point, or might this cause any inconsistencies, data loss,
[...]

Heh.

If gc --auto happens in the middle of e.g. a rebase, then it's possible
that there were more commits that were supposed to happen later.  You'd
need to run 'git rebase --continue' after interrupting the gc in that
case.

Interruption should never cause data loss, and as much as possible
commands should finish their work before running gc --auto.  Please
let us know if some command is violating that.

Thanks,
Jonathan
