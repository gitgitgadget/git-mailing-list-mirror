From: Duy Nguyen <pclouds@gmail.com>
Subject: Bug in get_pwd_cwd() in Windows?
Date: Mon, 21 Jul 2014 21:13:32 +0700
Message-ID: <CACsJy8BY8pyuZ0eY7qK86RGUh8Vp9FVE55TskcQhBTrwwPowEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 21 16:14:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9EMX-0001V7-7m
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 16:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932726AbaGUOOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 10:14:06 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:39449 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932508AbaGUOOE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 10:14:04 -0400
Received: by mail-qg0-f51.google.com with SMTP id a108so5340270qge.24
        for <git@vger.kernel.org>; Mon, 21 Jul 2014 07:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=yTnM2ahCRJ+DOaE1yDRcr+dbhlIcOJnBbtxxyd7q7L4=;
        b=OuDljKBmojYJctdFaORTSDvcRGVy//zGKHv1ce43YX9g6zbiYIeHJmwRL4wNy7sxGw
         /UVc8lFR0hg+jIQx62bO0aqeEVhzox4upLf7RC44TjHaWRdjmzddjIF5Thgeo/qR3wuN
         LJLG56a93u5dP6Ls80Ic9BbE2MRvP7EIZRUuQMZj3dNEIDwT0VDO9oOTXcPozlQxnqv4
         HfXEBjzNdvcpQ4rGZOP1WwizwVvqXUIHKBfRlKQIO/X4pWaekxNEzRx+oP1W5N0/zBtB
         C/9xADQ+JNlaTD3Be7qc38Nmnr3UwZw+2ah1/sSt1XI3NuezRrE9sU7C8J2LHjo1VgGb
         YcuA==
X-Received: by 10.224.122.83 with SMTP id k19mr43165812qar.78.1405952042888;
 Mon, 21 Jul 2014 07:14:02 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Mon, 21 Jul 2014 07:13:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253968>

This function tests if $PWD is the same as getcwd() using st_dev and
st_ino. But on Windows these fields are always zero
(mingw.c:do_lstat). If cwd is moved away, I think falling back to $PWD
is wrong. I don't understand the use of $PWD in the first place.
1b9a946 (Use nonrelative paths instead of absolute paths for cloned
repositories - 2008-06-05) does not explain much.
-- 
Duy
