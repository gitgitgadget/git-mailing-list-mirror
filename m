From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Restore umasks influence on the permissions of work tree
 created by clone
Date: Mon, 9 Jul 2012 20:21:11 +0200
Message-ID: <CALxABCY=0J6FN7MHLst4mf3PBV729U=wpVB3XNR-wWopdQ23nA@mail.gmail.com>
References: <alpine.LNX.2.00.1207061700060.2056@iabervon.org>
 <20120707215029.GA26819@blimp.dmz> <7vobnpn224.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 20:21:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoIaY-0004li-53
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 20:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599Ab2GISVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 14:21:33 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60744 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315Ab2GISVc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 14:21:32 -0400
Received: by yhmm54 with SMTP id m54so11195577yhm.19
        for <git@vger.kernel.org>; Mon, 09 Jul 2012 11:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fT4sMgu98QO4hC2loGmnT+1e7ra+7c6RYI1g9rU6RBw=;
        b=fm1s0V8lHmmZnmQd77DrgOFys8lpyzazsGglF1AgoywUpi7Im0jjS4ci8Ng7WlPtlp
         dp87p1mbQgHFQC0oSMoyKTHN0qZUgpirp2I/7k/NbWXXOveLzuifIcUCtUqkWintap1a
         qJYZkGgHWKLhBjsihM1iICEekOHs5YWUKJVko9vieHSfFbbpVOdtefLk/Xaab9cpuZPi
         ZP0KZ8zHBbnHrM87e8Yr4DmsV1dFwl6HeMp1ZR56xZy0j3Us+xireJa0XdpLzlqsT4G6
         R3zufmuaPS0WNZ3oECVcxKZmbdey37mJFXjyCs5UcJQnI43H4WAh51uTmf4cGJtiYrx7
         KViQ==
Received: by 10.236.173.9 with SMTP id u9mr1725873yhl.129.1341858091603; Mon,
 09 Jul 2012 11:21:31 -0700 (PDT)
Received: by 10.146.162.9 with HTTP; Mon, 9 Jul 2012 11:21:11 -0700 (PDT)
In-Reply-To: <7vobnpn224.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201215>

On Mon, Jul 9, 2012 at 3:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
>> The original (shell coded) version of the git-clone just used mkdir(1)
>> to create the working directories. The builtin changed the mode argument
>> to mkdir(2) to 0755, which was a bit unfortunate, as there are use
>
> A much more important reason why this is a good change (I think you
> could even say this is a bugfix) is because directories and files in
> the working tree are created with entry.c::create_directories() and
> entry.c::create_file(), and they do honour umask settings, and the
> top-level of the working tree should be handled the same way, no?

Well, the top-level directories of anything are often handled specially,
but yes, I agree indeed. Frankly, I wondered why the top-level wasn't
created safe_create_leading_directories() or something like that.

>> cases where umask-controlled creation is preferred and in any case
>> it is a well-known behaviour for new directory/file creation.
>
> Sign-off?

It was an RFC until now :)

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
