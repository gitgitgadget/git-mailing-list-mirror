Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B28D41F424
	for <e@80x24.org>; Wed, 25 Apr 2018 13:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752985AbeDYNCk convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 25 Apr 2018 09:02:40 -0400
Received: from rrzmta1.uni-regensburg.de ([194.94.155.51]:49562 "EHLO
        rrzmta1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbeDYNCh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 09:02:37 -0400
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Apr 2018 09:02:36 EDT
Received: from rrzmta1.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 88A635B313
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 14:53:18 +0200 (CEST)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by rrzmta1.uni-regensburg.de (Postfix) with ESMTP id C15275786E
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 14:53:16 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
        with Novell_GroupWise; Wed, 25 Apr 2018 14:53:16 +0200
Message-Id: <5AE07A3A020000A10002B5C5@gwsmtp1.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.0.1 
Date:   Wed, 25 Apr 2018 14:53:14 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <git@vger.kernel.org>
Subject: java diffs show no method context
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

This is for git 2.13.6, and it may be an FAQ or frequent feature request. Anyway:
I'm new to Java, and writing my first project using Git, I found that "git diff" only reports the class in the diff context, but not the method (as seen for C, for example).
I'd wish to have the method where the diff is located. Here is an example chunk:


@@ -100,6 +119,8 @@ public class PdfParser {
        PdfObject obj, value;
        PdfObjectName name;
        for ( int pos = startIndex; pos < endIndex; pos += 2 ) {
+           if ( (obj = objects.get(pos)).type != PdfObject.Type.Name )
+               exception("Name expected");
            name = (PdfObjectName) obj;
            if ( pos + 1 == endIndex )
                exception("missing value");

The corrsponding definition of the method is like this:

    /**
     * Populate Dictionary with parsed objects
     * @param dict Dictionary to fill
     * @param startIndex Position of first item to add
     * @param endIndex Position of first item not to add
     */
    private void populateDictionary(PdfObjectDictionary dict, int startIndex, in
t endIndex)
    {
...

Regards,
Ulrich




