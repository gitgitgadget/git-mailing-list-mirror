From: Brian Gesiak <modocache@gmail.com>
Subject: Re: [PATCH 01/15] builtin/add.c: rearrange xcalloc arguments
Date: Tue, 27 May 2014 11:22:00 +0900
Message-ID: <CAN7MxmUPH5-qgZQ-Wm0GeenNmqHvtwtx5WkXynNX9zRP3Yr1tQ@mail.gmail.com>
References: <1401118436-66090-1-git-send-email-modocache@gmail.com>
	<1401118436-66090-2-git-send-email-modocache@gmail.com>
	<20140526231156.GA8570@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Jeremiah Mahler <jmmahler@gmail.com>,
	Brian Gesiak <modocache@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 27 04:26:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp75n-0005AN-Kg
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 04:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbaE0CWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 22:22:04 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36974 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbaE0CWB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 22:22:01 -0400
Received: by mail-ig0-f174.google.com with SMTP id h3so557737igd.1
        for <git@vger.kernel.org>; Mon, 26 May 2014 19:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=KDqBdX6sQ5Nog0ps6Hu8YTRrTlDuoeU8BfT0XVX+K4I=;
        b=vH6JgSoPfYG9wFLHI8tId55f5DdebFOyl1c26xpV9KGWEjXjIAWxd9eadmvAMMbUTs
         AYg77R8g8KTvW+8YHHrYdXpe67lSwRf0dUbaDfSUn+Q3krUCbTLUAC0YVseEiliOlXF5
         vxIUfQ8UDk/aRbSzrJjBiyges/z2dNHgVUR9OAV7B9n6kBf3/rzhnqMiBqzR0ce2OAnN
         OlJsFZBI+FzRG//WF1xitlgKLbOG/NGSH13WkBmRzwMNqqz6iNktMs+iEgCRszSS9IaT
         qFUsqFVRBSGN3xcG1qd1uyGQWhSyl1Bj/6G4juidip6whQHknXZbrY3DOB+jKF99FSRG
         e0uA==
X-Received: by 10.50.97.68 with SMTP id dy4mr29883896igb.8.1401157320580; Mon,
 26 May 2014 19:22:00 -0700 (PDT)
Received: by 10.64.55.165 with HTTP; Mon, 26 May 2014 19:22:00 -0700 (PDT)
In-Reply-To: <20140526231156.GA8570@hudson.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250136>

My apologies! I based my work off of maint, branching off of eea591.

My reasoning was that Documentation/SubmittingPatches states that "a
bugfix should be based on 'maint'". [1] Now that I think about it,
this is probably not the kind of "bug" that statement had in mind.

Should I reroll the patch based on master?

- Brian Gesiak

[1] https://github.com/git/git/blob/4a28f169ad29ba452e0e7bea2583914c10c58322/Documentation/SubmittingPatches#L9

On Tue, May 27, 2014 at 8:11 AM, Jeremiah Mahler <jmmahler@gmail.com> wrote:
> Brian,
>
> On Tue, May 27, 2014 at 12:33:42AM +0900, Brian Gesiak wrote:
>> xcalloc takes two arguments: the number of elements and their size.
>> run_add_interactive passes the arguments in reverse order, passing the
>> size of a char*, followed by the number of char* to be allocated.
>> Rearrgange them so they are in the correct order.
>>
>> Signed-off-by: Brian Gesiak <modocache@gmail.com>
>> ---
>>  builtin/add.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/add.c b/builtin/add.c
>> index 672adc0..488acf4 100644
>> --- a/builtin/add.c
>> +++ b/builtin/add.c
>> @@ -248,7 +248,7 @@ int run_add_interactive(const char *revision, const char *patch_mode,
>>       int status, ac, i;
>>       const char **args;
>>
>> -     args = xcalloc(sizeof(const char *), (pathspec->nr + 6));
>> +     args = xcalloc((pathspec->nr + 6), sizeof(const char *));
>>       ac = 0;
>>       args[ac++] = "add--interactive";
>>       if (patch_mode)
>>
>
> This patch doesn't apply to any of the branches I have available
> (master, pu, next).  And there is no line containing "pathspec->nr + 6"
> anywhere in my builtin/add.c.  Which branch is your work based off?
>
> --
> Jeremiah Mahler
> jmmahler@gmail.com
> http://github.com/jmahler
