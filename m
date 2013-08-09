From: Diogo de Campos <campos@esss.com.br>
Subject: git rebase --interactive using short SHA-1's internally
Date: Fri, 9 Aug 2013 16:22:45 -0300
Message-ID: <CAMebvcT7Tb1PXsKmRuSNCqOhJEbkPJAG2tzW6FjWCa6hH-+ffA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 09 21:22:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7sGx-00080d-EX
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 21:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030810Ab3HITWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 15:22:47 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:58516 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030794Ab3HITWq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 15:22:46 -0400
Received: by mail-wi0-f174.google.com with SMTP id j17so60071wiw.7
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 12:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=esss.com.br; s=google;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=4ABmlrvC3+nSEH/BAQUgIEKH2ft+Xh8aqoTrtySlpoU=;
        b=lHhjzWfogyntj6XD0ZykfjQuh8ciezMZZDsaBm+1l9gI265eeT8R9BGW4WJu2+wQC7
         vT4NfWc4SX+f984MtJbz7IKz/NXe/IuadQ6bP0+0LaAllxsAcq12qwwAhI61GinvKBeC
         oSBwxhcm4qZhetUYASw7KmgdwrwjVfz41DTlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=4ABmlrvC3+nSEH/BAQUgIEKH2ft+Xh8aqoTrtySlpoU=;
        b=X/XEe1WpGG0wjXDF/9ZuLhr8K0l5GSZcelYgykzrFBKUXG59yJY9AhXgfRTaRZxbJP
         iyBKT8Z9t2Sl4aomeDb7IqYttrHZW9TIfg6bttQOFSXJ/5Ep/jaC9VcTLT3kIhsHdW0g
         1eRcV8c2d0qEuykuK5z8Zhy7cjw8CEYxQ/XA7yXv47toQXpIbl4Y6QJjqa8dU7CgPxDj
         zIK2ZGi34dT4JHBOibNaGEwBh0J9gDEQBGyTFSbIjCX53fachtkVWnAKvhHDKO3K9OeQ
         1dCwsojYczH7xKuBQha/4h92thyZkz9Sr6JCNDM518xoRJwn6Fgjb6GUaw38CynPtlmQ
         rJUA==
X-Gm-Message-State: ALoCoQnGPPqY27GM4mVDw6i6LriTWh6GznxO2TYkA3wrybLKUP9JS4VYx7qkph4FSketiWI5oO+6
X-Received: by 10.194.19.5 with SMTP id a5mr1164993wje.48.1376076165345; Fri,
 09 Aug 2013 12:22:45 -0700 (PDT)
Received: by 10.216.159.68 with HTTP; Fri, 9 Aug 2013 12:22:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232012>

Had some problems rebasing a large repository, fatal error because a
short SHA-1 ref was ambiguous.

After a quick inspection of git-rebase--interactive.sh, I found that
it uses short refs in a few places (git rev-parse --short). Removing
that option fixed my problem.


See:
https://github.com/git/git/blob/master/git-rebase--interactive.sh#L902

-- 
Diogo Campos
